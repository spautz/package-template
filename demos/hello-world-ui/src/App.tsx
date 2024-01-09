import 'react';

import { helloWorld } from '#node-library-template';
import { TodoComponent } from '#react-library-template';

function App() {
  return (
    <>
      <TodoComponent>{helloWorld}</TodoComponent>
    </>
  );
}

export { App };
