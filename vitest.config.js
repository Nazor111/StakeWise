import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true, // enables global imports like `describe`, `it`, etc.
    environment: 'node', // specify environment if running in Node.js
  },
});
