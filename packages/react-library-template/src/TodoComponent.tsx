import { helloWorld } from '@spautz/node-library-template';
import React, { type ReactNode } from 'react';

export interface TodoComponentProps {
  children?: ReactNode;
}

const TodoComponent: React.FC<TodoComponentProps> = (props) => {
  const { children = helloWorld } = props;
  return <React.Fragment>TodoComponent: {children}</React.Fragment>;
};

export { TodoComponent };
