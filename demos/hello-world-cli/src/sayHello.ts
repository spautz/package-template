import { helloWorld } from '@spautz/basic-library-template';

const sayHello = (): void => {
  // biome-ignore lint/suspicious/noConsole: This is a demo using the console
  console.log(helloWorld);
};

export { sayHello };
