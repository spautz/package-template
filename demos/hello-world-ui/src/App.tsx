import { helloWorld } from '#spautz/node-library-template';
import { TodoComponent } from '#spautz/react-library-template';

function App() {
  return (
    <>
      <TodoComponent>{helloWorld}</TodoComponent>
    </>
  );
}

export { App };
