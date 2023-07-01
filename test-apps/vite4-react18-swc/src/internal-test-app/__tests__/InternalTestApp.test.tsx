import 'react';
import { test, expect } from 'vitest';
import { render, screen } from '@testing-library/react';

import { InternalTestApp } from '../InternalTestApp';

test('renders InternalTestApp', () => {
  render(<InternalTestApp />);
  const internalTestAppElement = screen.getByText('TodoComponent: Hello World!');
  expect(internalTestAppElement).toBeInTheDocument();
});
