import React from 'react';
import { describe, expect, test } from 'vitest';
import { render, screen } from '@testing-library/react';

import { TodoProvider } from '../index';

describe('TodoProvider', () => {
  test('Renders without error', () => {
    render(<TodoProvider>Stuff</TodoProvider>);

    expect(screen.getByText('TodoProvider: Stuff')).toBeVisible();
  });
});
