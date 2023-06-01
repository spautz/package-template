// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import React from 'react';
import { describe, expect, test } from 'vitest';
import { act, render, screen } from '@testing-library/react';

import { App } from '../App';

describe('App', () => {
  test('Renders without error', () => {
    act(() => {
      render(<App />);
    });

    expect(screen.getByText('TodoProvider: Hello World!')).toBeVisible();
  });
});
