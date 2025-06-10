import { render, screen } from '@testing-library/react';
import { describe, expect, it } from 'vitest';

import { TodoComponent } from '../index.js';

describe('todocomponent', () => {
  it('renders without error', () => {
    render(<TodoComponent>My Content</TodoComponent>);

    expect(screen.getByText('TodoComponent: My Content')).toBeVisible();
  });
});
