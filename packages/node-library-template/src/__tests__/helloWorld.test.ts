import { describe, expect, test } from 'vitest';

import { helloWorld } from '../index';

describe('helloWorld', () => {
  test('exists', () => {
    expect(helloWorld).toEqual('Hello World!');
  });
});
