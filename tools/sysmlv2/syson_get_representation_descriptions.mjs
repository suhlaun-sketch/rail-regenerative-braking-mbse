const [endpoint, editingContextId, objectId] = process.argv.slice(2);
const query = `
query getRepresentationDescriptions($editingContextId: ID!, $objectId: ID!) {
  viewer {
    editingContext(editingContextId: $editingContextId) {
      representationDescriptions(objectId: $objectId) {
        edges { node { id label } }
      }
    }
  }
}`;
const response = await fetch(endpoint, {
  method: "POST",
  headers: { "content-type": "application/json" },
  body: JSON.stringify({ query, variables: { editingContextId, objectId } }),
});
const body = await response.json();
process.stdout.write(`${JSON.stringify(body, null, 2)}\n`);
