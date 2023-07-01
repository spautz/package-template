import React from 'react';
import { render, screen } from '@testing-library/react';

import { InternalTestApp } from '../InternalTestApp';

test('renders InternalTestApp', () => {
  render(<InternalTestApp />);
  const internalTestAppElement = screen.getByText('TodoProvider: Hello World!');
  expect(internalTestAppElement).toBeInTheDocument();
});
