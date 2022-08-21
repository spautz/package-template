import { describe, expect, test } from 'vitest';

import { helloWorld } from '../index';

describe('helloWorld', () => {
  test('is exported', () => {
    expect(helloWorld).toEqual('Hello World!');
  });
});
