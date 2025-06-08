import { cleanup, render, screen } from '@testing-library/react';
import { afterEach, describe, expect, test, vitest } from 'vitest';

import { App } from '../App.js';

describe('App', () => {
  afterEach(() => {
    cleanup();
    vitest.resetModules();
  });

  test('Renders without error', () => {
    render(<App />);

    expect(screen.getByText('TodoComponent: Hello World!')).toBeVisible();
  });
});
