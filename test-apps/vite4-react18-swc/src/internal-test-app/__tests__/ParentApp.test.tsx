import 'react';
import { test, expect } from 'vitest';
import { render, screen } from '@testing-library/react';

import ParentApp from '../../App';

test('renders InternalTestApp', () => {
  render(<ParentApp />);
  const internalTestAppElement = screen.getByText('TodoProvider: Hello World!');
  expect(internalTestAppElement).toBeInTheDocument();
});
