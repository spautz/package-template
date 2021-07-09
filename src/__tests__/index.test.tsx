import React from 'react';
import { render, screen } from '@testing-library/react';

import { TODO, TodoComponent } from '..';

describe('TODO', () => {
  it('exists', () => {
    expect(TODO).toEqual('TODO');
  });
});

describe('TodoComponent', () => {
  it('Renders without error', () => {
    render(<TodoComponent>Stuff</TodoComponent>);

    expect(screen.getByText('TODO! Stuff')).toBeVisible();
  });
});
