import React, { ReactNode } from 'react';

export interface TodoProviderProps {
  children: ReactNode;
}

const TodoProvider: React.FC<TodoProviderProps> = (props) => {
  const { children } = props;
  return <React.Fragment>TodoProvider: {children}</React.Fragment>;
};

export { TodoProvider };
