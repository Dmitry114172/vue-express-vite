import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import { resolve } from 'path';

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
    server: {
    hmr: {
      protocol: 'ws',
      host: 'localhost',
      port: 5173,
    }
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'), // Указываем алиас для папки src
    },
  },
});