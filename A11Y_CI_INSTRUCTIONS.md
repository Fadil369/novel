# Accessibility CI Instructions

Use pa11y with headless Chrome in CI. Example GitHub Action job:

- name: Install Node & pa11y
  run: |
    npm ci
    npm install -g pa11y@6

- name: Run pa11y
  run: |
    pa11y "file://$GITHUB_WORKSPACE/my-novel/vol12.html" --standard WCAG2AA

If pa11y cannot run headless Chrome due to environment constraints, use Axe CLI or Lighthouse in CI.
