import React, { ReactNode } from 'react';

export interface TodoComponentProps {
  children: ReactNode;
}

const TodoComponent: React.FC<TodoComponentProps> = (props) => {
  const { children } = props;
  return <React.Fragment>TodoComponent: {children}</React.Fragment>;
};

export { TodoComponent };
