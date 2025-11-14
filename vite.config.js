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
        solid({
            ssr: false,
            hydrate: true,
        }),
        tailwindcss(),
    ],
    server: {
        cors: true,
    },
    appType: 'mpa',
});
