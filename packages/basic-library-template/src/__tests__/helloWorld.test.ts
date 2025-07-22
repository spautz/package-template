import { describe, expect, it } from 'vitest';

import { helloWorld } from '../index.js';

describe('helloworld', () => {
  it('is exported', () => {
    expect(helloWorld).toBe('Hello World!');
  });
});
