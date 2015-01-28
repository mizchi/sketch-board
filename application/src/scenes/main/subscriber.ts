export = subscriber;
function subscriber(subscribe) {
  subscribe(':update', (context) => () => {
    context.update({});
  });
}
