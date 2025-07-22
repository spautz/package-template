import { helloWorld } from '@spautz/basic-library-template';
import React from 'react';
import type { ReactNode } from 'react';

export interface TodoComponentProps {
  children?: ReactNode;
}

const TodoComponent: React.FC<TodoComponentProps> = (props) => {
  const { children = helloWorld } = props;
  return <React.Fragment>TodoComponent: {children}</React.Fragment>;
};

export { TodoComponent };
