#!/usr/bin/env node

const command = process.argv[2];

if (command === 'mcp') {
  await import('./server.js');
} else {
  console.error('Usage: react-library-template mcp');
  process.exitCode = 1;
}
