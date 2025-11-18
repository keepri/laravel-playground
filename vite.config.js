import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from "@tailwindcss/vite";
import solid from 'vite-plugin-solid';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.jsx'],
            refresh: true,
        }),
        solid(),
        tailwindcss(),
    ],
    server: {
        host: '0.0.0.0',
        port: Number(process.env.VITE_PORT) ?? 5173,
        cors: true,
        hmr: {
            host: 'localhost'
        }
    },
    appType: 'mpa',
});
