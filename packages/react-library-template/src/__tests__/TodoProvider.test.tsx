import React from 'react';
import { describe, expect, test } from 'vitest';
import { render, screen } from '@testing-library/react';

import { TodoComponent } from '../index.js';

describe('TodoProvider', () => {
  test('Renders without error', () => {
    render(<TodoComponent>Stuff</TodoComponent>);

    expect(screen.getByText('TodoComponent: Stuff')).toBeVisible();
  });
});
