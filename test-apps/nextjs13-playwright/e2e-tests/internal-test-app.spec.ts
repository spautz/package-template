import { test, expect } from '@playwright/test';

test('renders InternalTestApp from layout', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('body')).toContainText('TodoComponent: Hello World!');
  await expect(page.locator('body')).toContainText('Content = "layout"');
});

test('renders InternalTestApp from page', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('main')).toContainText('TodoComponent: Hello World!');
  await expect(page.locator('main')).toContainText('Content = "page"');
});
