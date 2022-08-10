import React from 'react';
import { describe, expect, test } from 'vitest';
import { render, screen } from '@testing-library/react';

import { TODO, TodoRoot } from '../index';

describe('TODO', () => {
  test('exists', () => {
    expect(TODO).toEqual('TODO');
  });
});

describe('TodoRoot', () => {
  test('Renders without error', () => {
    render(<TodoRoot>Stuff</TodoRoot>);

    expect(screen.getByText('TODO! Stuff')).toBeVisible();
  });
});
