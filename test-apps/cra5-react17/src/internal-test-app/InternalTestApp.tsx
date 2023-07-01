import React from 'react';

import { helloWorld } from '@spautz/node-library-template';
import { TodoComponent } from '@spautz/react-library-template';

function InternalTestApp() {
  return <TodoComponent>{helloWorld}</TodoComponent>;
}

export { InternalTestApp };
