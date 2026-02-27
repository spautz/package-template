import { helloWorld } from '@spautz/basic-library-template';

const sayHello = (): void => {
  // biome-ignore lint/suspicious/noConsole: Intentional console for testing
  console.log(helloWorld);
};

export { sayHello };
