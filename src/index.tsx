import React from 'react';

const TODO = 'TODO';

const TodoComponent: React.FC = (props) => {
  const { children } = props;
  return <React.Fragment>TODO! {children}</React.Fragment>;
};

export { TODO, TodoComponent };
