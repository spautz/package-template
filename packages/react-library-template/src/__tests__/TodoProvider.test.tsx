import React from 'react';
import { describe, expect, test } from 'vitest';
import { render, screen } from '@testing-library/react';

import { TodoComponent } from '../index.js';

describe('TodoProvider', () => {
  test('Renders without error', () => {
    render(<TodoComponent>My Content</TodoComponent>);

    expect(screen.getByText('TodoProvider: My Content')).toBeVisible();
  });
});
