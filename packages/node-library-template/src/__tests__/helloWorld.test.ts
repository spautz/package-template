import { describe, expect, test } from 'vitest';

import { helloWorld } from '../index.js';

describe('helloWorld', () => {
  test('is exported', () => {
    expect(helloWorld).toEqual('Hello World!');
  });
});
