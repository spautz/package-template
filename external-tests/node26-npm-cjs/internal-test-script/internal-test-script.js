#!/usr/bin/env node

const { helloWorld } = require('@spautz/basic-library-template');

if (helloWorld !== 'Hello World!') {
  throw new Error('@spautz/basic-library-template did not export "Hello World!"');
}

console.log('helloWorld: ', helloWorld);
