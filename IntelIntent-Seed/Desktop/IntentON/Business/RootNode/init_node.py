"""
IntentON Root Node Initializer with Microsoft Entra ID Integration
Business Domain Implementation
"""

import os
import json
import yaml
import asyncio
import logging
from typing import Dict, List, Optional, Any
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

# Azure and Microsoft Identity imports
try:
    from azure.identity import DefaultAzureCredential, InteractiveBrowserCredential
    from msal import PublicClientApplication, ConfidentialClientApplication
    import jwt
except ImportError:
    print("Warning: Azure identity packages not found. Installing required packages...")
    import subprocess
    subprocess.check_call(["pip", "install", "azure-identity", "msal", "PyJWT", 
                         "pyyaml", "cryptography"])
    from azure.identity import DefaultAzureCredential, InteractiveBrowserCredential
    from msal import PublicClientApplication, ConfidentialClientApplication
    import jwt

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@dataclass
class PAIdentity:
    """Personalized Agent Identifier with multi-identity binding"""
    pa_id: str
    github_identity: Optional[str] = None
    microsoft_365_identity: Optional[str] = None
    entra_object_id: Optional[str] = None
    roles: List[str] = None
    permissions: Dict[str, Any] = None
    created_at: datetime = None
    last_verified: datetime = None
    
    def __post_init__(self):
        if self.roles is None:
            self.roles = []
        if self.permissions is None:
            self.permissions = {}
        if self.created_at is None:
            self.created_at = datetime.utcnow()


class AccessControlManager:
    """Manages role-based access control with recursive delegation"""
    
    ROLE_HIERARCHY = {
        'owner': ['admin', 'contributor', 'reader'],
        'admin': ['contributor', 'reader'],
        'contributor': ['reader'],
        'reader': []
    }
    
    PERMISSION_MATRIX = {
        'owner': {
            'create': True, 'read': True, 'update': True, 'delete': True,
            'delegate': True, 'inherit': True, 'override': True
        },
        'admin': {
            'create': True, 'read': True, 'update': True, 'delete': True,
            'delegate': True, 'inherit': True, 'override': False
        },
        'contributor': {
            'create': True, 'read': True, 'update': True, 'delete': False,
            'delegate': False, 'inherit': True, 'override': False
        },
        'reader': {
            'create': False, 'read': True, 'update': False, 'delete': False,
            'delegate': False, 'inherit': False, 'override': False
        }
    }
    
    def __init__(self, pa_identity: PAIdentity):
        self.identity = pa_identity
        self.delegation_chain = []
        
    def validate_permission(self, action: str, resource: str = None) -> bool:
        """Validate if the current identity has permission for an action"""
        for role in self.identity.roles:
            if role in self.PERMISSION_MATRIX:
                if self.PERMISSION_MATRIX[role].get(action, False):
                    logger.info(f"Permission granted: {action} for role {role}")
                    return True
        
        logger.warning(f"Permission denied: {action} for identity {self.identity.pa_id}")
        return False
    
    def can_delegate_to(self, target_role: str) -> bool:
        """Check if current identity can delegate to target role"""
        if not self.validate_permission('delegate'):
            return False
            
        for role in self.identity.roles:
            if role in self.ROLE_HIERARCHY:
                if target_role in self.ROLE_HIERARCHY[role]:
                    return True
        return False
    
    def inherit_permissions(self, parent_identity: PAIdentity) -> Dict[str, Any]:
        """Inherit permissions from parent with scope reduction"""
        inherited = {}
        
        if not self.validate_permission('inherit'):
            return inherited
            
        # Apply scope reduction - child cannot have more permissions than parent
        for parent_role in parent_identity.roles:
            if parent_role in self.ROLE_HIERARCHY:
                for child_role in self.identity.roles:
                    if child_role in self.ROLE_HIERARCHY[parent_role]:
                        inherited[child_role] = self.PERMISSION_MATRIX[child_role]
        
        return inherited


class EntraIDAuthenticator:
    """Handles Microsoft Entra ID authentication and identity binding"""
    
    def __init__(self, config_path: str = "config.yaml"):
        self.config = self._load_config(config_path)
        self.tenant_id = self.config.get('azure', {}).get('tenant_id', 
                                       os.environ.get('AZURE_TENANT_ID'))
        self.client_id = self.config.get('azure', {}).get('client_id', 
                                       os.environ.get('AZURE_CLIENT_ID'))
        self.client_secret = os.environ.get('AZURE_CLIENT_SECRET')
        self.graph_client = None
        self.msal_app = None
        
    def _load_config(self, config_path: str) -> Dict:
        """Load configuration from YAML file"""
        try:
            with open(config_path, 'r') as f:
                return yaml.safe_load(f)
        except Exception as e:
            logger.warning(f"Could not load config from {config_path}: {str(e)}")
            return {}
    
    async def authenticate(self) -> Dict[str, Any]:
        """Authenticate using Microsoft Entra ID"""
        try:
            if self.client_secret:
                # Confidential client for service principals
                self.msal_app = ConfidentialClientApplication(
                    self.client_id,
                    authority=f"https://login.microsoftonline.com/{self.tenant_id}",
                    client_credential=self.client_secret
                )
                result = self.msal_app.acquire_token_for_client(
                    scopes=["https://graph.microsoft.com/.default"]
                )
            else:
                # Public client for interactive authentication
                self.msal_app = PublicClientApplication(
                    self.client_id,
                    authority=f"https://login.microsoftonline.com/{self.tenant_id}"
                )
                result = self.msal_app.acquire_token_interactive(
                    scopes=["User.Read", "Directory.Read.All"]
                )
            
            if "access_token" in result:
                logger.info("Successfully authenticated with Entra ID")
                return result
            else:
                logger.warning(f"Authentication failed: {result.get('error_description')}")
                return {}
                
        except Exception as e:
            logger.error(f"Authentication error: {str(e)}")
            # Fall back to simulated authentication for development
            return self._simulated_auth()
            
    def _simulated_auth(self) -> Dict[str, Any]:
        """Provide simulated auth for development without Azure credentials"""
        logger.warning("Using simulated authentication for development")
        return {
            "access_token": "simulated_token",
            "id_token": "simulated_id_token",
            "expires_in": 3600
        }
    
    async def bind_github_identity(self, pa_identity: PAIdentity, 
                                 github_token: str = None) -> bool:
        """Bind GitHub identity to PA ID"""
        try:
            # If token is provided, verify GitHub token and extract identity
            if github_token:
                github_user = await self._verify_github_token(github_token)
                pa_identity.github_identity = github_user.get('login')
            else:
                # Try to get from environment for CI/CD scenarios
                pa_identity.github_identity = os.environ.get('GITHUB_ACTOR', 
                                                           'simulated_github_user')
            
            logger.info(f"Bound GitHub identity: {pa_identity.github_identity}")
            return True
        except Exception as e:
            logger.error(f"Failed to bind GitHub identity: {str(e)}")
            return False
    
    async def bind_microsoft_identity(self, pa_identity: PAIdentity, 
                                    access_token: str) -> bool:
        """Bind Microsoft 365 identity to PA ID"""
        try:
            if access_token == "simulated_token":
                pa_identity.microsoft_365_identity = "user@example.com"
                pa_identity.entra_object_id = "simulated-object-id"
            else:
                # Decode JWT token to get user information
                decoded = jwt.decode(access_token, options={"verify_signature": False})
                pa_identity.microsoft_365_identity = decoded.get('upn') or decoded.get('email')
                pa_identity.entra_object_id = decoded.get('oid')
                
            logger.info(f"Bound Microsoft 365 identity: {pa_identity.microsoft_365_identity}")
            return True
        except Exception as e:
            logger.error(f"Failed to bind Microsoft identity: {str(e)}")
            return False
    
    async def _verify_github_token(self, token: str) -> Dict:
        """Verify GitHub token and return user info"""
        # Placeholder for GitHub API call
        # In production, this would make an actual API call to GitHub
        return {"login": os.environ.get('GITHUB_ACTOR', 'github_user')}


class IntentONRootNode:
    """Main root node class with recursive orchestration"""
    
    def __init__(self, domain: str, pa_id: str = None):
        self.domain = domain
        self.pa_id = pa_id or self._generate_pa_id()
        self.identity = PAIdentity(pa_id=self.pa_id)
        self.authenticator = EntraIDAuthenticator()
        self.access_manager = AccessControlManager(self.identity)
        self.children = []
        self.parent = None
        self.manifest = self._load_manifest()
        
    def _generate_pa_id(self) -> str:
        """Generate a unique PA ID"""
        from uuid import uuid4
        timestamp = datetime.utcnow().strftime('%Y%m%d%H%M%S')
        return f"PA-{self.domain.upper()}-{timestamp}-{str(uuid4())[:8]}"
    
    def _load_manifest(self) -> Dict:
        """Load intent manifest"""
        manifest_path = Path("intent_manifest.json")
        if manifest_path.exists():
            with open(manifest_path, 'r') as f:
                return json.load(f)
        return {}
    
    async def initialize(self) -> bool:
        """Initialize the root node with authentication and access control"""
        try:
            logger.info(f"Initializing {self.domain} root node with PA ID: {self.pa_id}")
            
            # Authenticate with Entra ID
            auth_result = await self.authenticator.authenticate()
            
            # Bind Microsoft identity
            if auth_result and 'access_token' in auth_result:
                await self.authenticator.bind_microsoft_identity(
                    self.identity, 
                    auth_result['access_token']
                )
            
            # Bind GitHub identity if in GitHub Actions environment
            if os.environ.get('GITHUB_ACTIONS'):
                github_token = os.environ.get('GITHUB_TOKEN')
                await self.authenticator.bind_github_identity(self.identity, github_token)
            else:
                # Simulate for development
                await self.authenticator.bind_github_identity(self.identity)
            
            # Set default roles based on domain
            self._assign_default_roles()
            
            # Initialize recursive structure if needed
            if self.manifest.get('recursive', {}).get('enabled', False):
                await self._initialize_recursive_structure()
            
            logger.info(f"Root node {self.pa_id} initialized successfully")
            return True
            
        except Exception as e:
            logger.error(f"Failed to initialize root node: {str(e)}")
            return False
    
    def _assign_default_roles(self):
        """Assign default roles based on domain"""
        role_mapping = {
            'Personal': ['owner'],
            'Family': ['admin'],
            'Business': ['contributor'],
            'Enterprise': ['admin']
        }
        self.identity.roles = role_mapping.get(self.domain, ['reader'])
        logger.info(f"Assigned roles: {self.identity.roles}")
    
    async def _initialize_recursive_structure(self):
        """Initialize recursive child nodes"""
        max_depth = self.manifest.get('recursive', {}).get('max_depth', 5)
        
        if self.get_depth() < max_depth:
            for child_config in self.manifest.get('children', []):
                child_node = await self.spawn_child(child_config)
                if child_node:
                    self.children.append(child_node)
    
    async def spawn_child(self, config: Dict) -> Optional['IntentONRootNode']:
        """Spawn a child node with inherited permissions"""
        if not self.access_manager.validate_permission('create'):
            logger.warning("Insufficient permissions to spawn child node")
            return None
            
        try:
            child_node = IntentONRootNode(
                domain=config.get('domain', self.domain),
                pa_id=self._generate_pa_id()
            )
            child_node.parent = self
            
            # Inherit permissions with scope reduction
            inherited_perms = child_node.access_manager.inherit_permissions(self.identity)
            child_node.identity.permissions.update(inherited_perms)
            
            await child_node.initialize()
            logger.info(f"Spawned child node: {child_node.pa_id}")
            return child_node
            
        except Exception as e:
            logger.error(f"Failed to spawn child node: {str(e)}")
            return None
    
    def get_depth(self) -> int:
        """Get the depth of this node in the hierarchy"""
        depth = 0
        current = self.parent
        while current:
            depth += 1
            current = current.parent
        return depth
    
    def delegate_permission(self, target_pa_id: str, permission: str) -> bool:
        """Delegate specific permission to another PA ID"""
        if not self.access_manager.validate_permission('delegate'):
            return False
            
        # Find target node and delegate
        target_node = self._find_node_by_pa_id(target_pa_id)
        if target_node:
            target_node.identity.permissions[permission] = True
            logger.info(f"Delegated {permission} to {target_pa_id}")
            return True
        return False
    
    def _find_node_by_pa_id(self, pa_id: str) -> Optional['IntentONRootNode']:
        """Recursively find a node by PA ID"""
        if self.pa_id == pa_id:
            return self
        for child in self.children:
            found = child._find_node_by_pa_id(pa_id)
            if found:
                return found
        return None


async def main():
    """Main entry point for root node initialization"""
    # Determine domain from environment or config
    domain = "Business"
    
    # Create and initialize root node
    root_node = IntentONRootNode(domain=domain)
    success = await root_node.initialize()
    
    if success:
        logger.info(f"IntentON {domain} root node is active")
        logger.info(f"PA ID: {root_node.pa_id}")
        logger.info(f"Microsoft Identity: {root_node.identity.microsoft_365_identity}")
        logger.info(f"GitHub Identity: {root_node.identity.github_identity}")
        logger.info(f"Roles: {root_node.identity.roles}")
    else:
        logger.error("Failed to initialize IntentON root node")
        exit(1)


if __name__ == "__main__":
    asyncio.run(main())