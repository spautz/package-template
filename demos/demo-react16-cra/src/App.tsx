// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import React from 'react';

import { helloWorld } from '@package-template/node-library-template';
import { TodoProvider } from '@package-template/react-library-template';

function App() {
  return <TodoProvider>{helloWorld}</TodoProvider>;
}

export { App };
