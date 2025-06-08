import { helloWorld } from '@spautz/node-library-template';
import { afterEach, describe, expect, test, vi } from 'vitest';

import { sayHello } from '../sayHello.js';

describe('sayHello', () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  test('prints "Hello World"', () => {
    const consoleLogSpy = vi.spyOn(console, 'log').mockImplementationOnce(() => null);

    sayHello();

    expect(consoleLogSpy).toHaveBeenCalledTimes(1);
    expect(consoleLogSpy).toHaveBeenCalledWith(helloWorld);
    consoleLogSpy.mockRestore();
  });
});
