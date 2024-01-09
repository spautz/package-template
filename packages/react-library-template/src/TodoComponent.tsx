import React, { ReactNode } from 'react';
import { helloWorld } from '@spautz/node-library-template';

export interface TodoComponentProps {
  children?: ReactNode;
}

const TodoComponent: React.FC<TodoComponentProps> = (props) => {
  const { children = helloWorld } = props;
  return <React.Fragment>TodoComponent: {children}</React.Fragment>;
};

export { TodoComponent };
