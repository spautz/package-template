import { describe, expect, it } from 'vitest';

import { serverOnlyValue } from '../index.js';

describe('serverOnlyValue', () => {
  it('is exported', () => {
    expect(serverOnlyValue).toBe('This is a server-only value');
  });
});
