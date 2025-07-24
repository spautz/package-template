import { describe, expect, it } from 'vitest';

import { browserOnlyValue } from '../index.js';

describe('browserOnlyValue', () => {
  it('is exported', () => {
    expect(browserOnlyValue).toBe('This is a browser-only value');
  });
});
