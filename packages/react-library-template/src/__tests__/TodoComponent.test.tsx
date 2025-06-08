import { render, screen } from '@testing-library/react';
import { describe, expect, test } from 'vitest';

import { TodoComponent } from '../index.js';

describe('TodoComponent', () => {
  test('Renders without error', () => {
    render(<TodoComponent>My Content</TodoComponent>);

    expect(screen.getByText('TodoComponent: My Content')).toBeVisible();
  });
});
