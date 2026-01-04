import esbuild from "esbuild";
import sveltePlugin from "esbuild-svelte";
import importGlobPluginDefault from "esbuild-plugin-import-glob";
const importGlobPlugin = importGlobPluginDefault.default;
import { sveltePreprocess } from "svelte-preprocess";
import { fileURLToPath } from 'url';
import path from 'path';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const args = process.argv.slice(2)
const watch = args.includes("--watch")
const deploy = args.includes("--deploy")

let clientConditions = ["svelte", "browser"]
let serverConditions = ["svelte"]

if (!deploy) {
    clientConditions.push("development")
    serverConditions.push("development")
}

const preprocess = sveltePreprocess({
    typescript: {
        compilerOptions: {
            target: "esnext", 
            module: "esnext",
        }
    }
})

let optsClient = {
    entryPoints: ["js/app.js"],
    platform: 'browser',
    external: ['node:*'],
    bundle: true,
    minify: deploy,
    treeShaking: true,
    metafile: true,
    conditions: clientConditions,
    alias: {svelte: "svelte"},
    outdir: "../priv/static/assets/js",
    logLevel: "info",
    sourcemap: watch ? "inline" : false,
    tsconfig: "./tsconfig.json",
    plugins: [
        importGlobPlugin(),
        sveltePlugin({
            preprocess: preprocess,
            compilerOptions: {dev: !deploy, css: "injected", generate: "client"},
        }),
    ],
    external: ["maplibre-gl", "deck.gl", "node:*", "node:crypto"]
}

let optsServer = {
    entryPoints: ["js/server.js"],
    platform: "node",
    bundle: true,
    minify: false,
    target: "node20",
    conditions: serverConditions,
    alias: {svelte: "svelte"},
    outdir: "../priv/svelte",
    logLevel: "info",
    sourcemap: watch ? "inline" : false,
    tsconfig: "./tsconfig.json",
    plugins: [
        importGlobPlugin(),
        sveltePlugin({
            preprocess: preprocess,
            compilerOptions: {dev: !deploy, css: "injected", generate: "server"},
        }),
    ]
}

if (watch) {
    esbuild
        .context(optsClient)
        .then(ctx => ctx.watch())
        .catch(_error => process.exit(1))

    esbuild
        .context(optsServer)
        .then(ctx => ctx.watch())
        .catch(_error => process.exit(1))
} else {
    esbuild.build(optsClient)
    esbuild.build(optsServer)
}
