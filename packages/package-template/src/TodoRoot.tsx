import React, { ReactNode } from 'react';

export interface TodoRootProps {
  children: ReactNode;
}

const TodoRoot: React.FC<TodoRootProps> = (props) => {
  const { children } = props;
  return <React.Fragment>TODO! {children}</React.Fragment>;
};

export { TodoRoot };
