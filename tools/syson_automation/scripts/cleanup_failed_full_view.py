"""Delete an automation-owned failed formal view before recreating it."""
from __future__ import annotations
import json
import sys
import uuid
from pathlib import Path
from tools.syson_automation.src.syson_client import SysONClient
from tools.syson_automation.src.representation_service import REGISTRY

root = Path(__file__).resolve().parents[3]
state = json.loads((root/'tools/syson_automation/cache/full_final_project.json').read_text(encoding='utf-8'))
name = sys.argv[1]
key = state['project_id'] + ':' + name
registry = json.loads(REGISTRY.read_text(encoding='utf-8'))
owned = registry.get(key)
if not owned or owned['name'] != name or owned['created_by'] != 'syson_automation':
    raise RuntimeError('Target is not registered as owned')
query = ('mutation($input:DeleteRepresentationInput!){deleteRepresentation(input:$input)'
         '{__typename}}')
client = SysONClient(timeout=60)
response = client.execute(query, {'input': {'id': str(uuid.uuid4()),
    'editingContextId': state['editing_context_id'], 'representationId': owned['id']}})['deleteRepresentation']
if 'Success' not in response['__typename']:
    raise RuntimeError(str(response))
registry.pop(key)
REGISTRY.write_text(json.dumps(registry, ensure_ascii=False, indent=2), encoding='utf-8')
print('DELETED_OWNED_FAILED_VIEW',name)
