#!/usr/bin/env node

import { helloWorld } from '@spautz/node-library-template';

if (helloWorld !== 'Hello World!') {
  throw new Error('@spautz/node-library-template did not export "Hello World!"');
}

console.log('helloWorld: ', helloWorld);
