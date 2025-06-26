import { helloWorld } from '@spautz/node-library-template';

const sayHello = () => {
  // biome-ignore lint/suspicious/noConsole: This is a demo using the console
  console.log(helloWorld);
};

export { sayHello };
