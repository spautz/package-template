import { helloWorld } from '#spautz/node-library-template';
import { TodoComponent } from '#spautz/react-library-template';

interface InternalTestAppProps {
  content?: boolean | number | string;
}

function InternalTestApp(props: InternalTestAppProps) {
  const { content } = props;

  return (
    <TodoComponent>
      {helloWorld}
      {content != null ? <div>Content = {JSON.stringify(content)}</div> : undefined}
    </TodoComponent>
  );
}

export { InternalTestApp };
