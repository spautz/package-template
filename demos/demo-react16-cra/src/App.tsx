// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import React from 'react';

import { helloWorld } from '@spautz/node-library-template';
import { TodoProvider } from '@spautz/react-library-template';

function App() {
  return <TodoProvider>{helloWorld}</TodoProvider>;
}

export { App };
