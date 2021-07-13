import React from 'react';
import { render } from '@testing-library/react';

import { App } from '../App';

describe('App', () => {
  it('renders a placeholder', () => {
    const { getByText } = render(<App />);

    expect(getByText('Demo goes here')).toBeInTheDocument();
  });
});
