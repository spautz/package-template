import { helloWorld } from '@spautz/basic-library-template';
import { TodoComponent } from '@spautz/react-library-template';
import type { JSX } from 'react/jsx-runtime';

function App(): JSX.Element {
  return <TodoComponent>{helloWorld}</TodoComponent>;
}

export { App };
