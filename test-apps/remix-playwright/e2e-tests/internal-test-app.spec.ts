import { test, expect } from '@playwright/test';

test('renders Remix test app', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('h1')).toContainText('Welcome to Remix');
});

test('renders InternalTestApp', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('body')).toContainText('TodoComponent: Hello World!');
});
