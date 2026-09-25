import json, unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class OfflineTests(unittest.TestCase):
 def test_graph_data_shape(self):
  d=json.loads((ROOT/'work'/'graph_data.json').read_text(encoding='utf-8'))
  self.assertEqual(d['meta']['counts']['selected_leaves'],90); self.assertEqual(len(d['items']),144); self.assertEqual(len(d['exposes']),517)
  self.assertEqual(sum(x['profile_active'] for x in d['exposes']),511); self.assertEqual(sum(not x['profile_active'] for x in d['exposes']),6)
  self.assertTrue(all(p['leaf'] for p in d['products'] if p['code'] in {'E100','D112','X111'}))
  products={p['code']:p for p in d['products']}; self.assertTrue(all(products[x['product_code']]['leaf'] for x in d['exposes']))
if __name__=='__main__': unittest.main()
