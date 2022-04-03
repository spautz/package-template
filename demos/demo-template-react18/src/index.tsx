import React from 'react';
import { createRoot } from 'react-dom/client';

import { App } from './App';
// import { reportWebVitals } from './reportWebVitals';

const rootEl = document.getElementById('root');

if (!rootEl) {
  throw new Error('Root element not found');
}

const reactRoot = createRoot(rootEl);
reactRoot.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
// reportWebVitals();
