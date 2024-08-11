import path from "node:path";

import { defineConfig } from "vitest/config";

const workspaceRoot = path.resolve(import.meta.dirname, `..`);
const projectRoot = process.cwd();
const projectName = path.basename(projectRoot);
const projectArtifacts = path.join(workspaceRoot, `artifacts`, projectName);

export default defineConfig({
	cacheDir: path.join(projectArtifacts, `vite`),
	test: {
		coverage: {
			all: true,
			clean: false, // Workspace-wide coverage directory; do not clean
			provider: `v8`,
			// Coverage reporter
			reporter: [[`cobertura`, { file: `${projectName}.cobertura.xml` }]],
			reportsDirectory: path.join(projectArtifacts, `test-results`),
			thresholds: {
				branches: 80,
				functions: 80,
				lines: 80,
				perFile: true,
			},
		},
		// Unit test reporter (not coverage)
		reporters: process.env[`GITHUB_ACTIONS`]
			? [`dot`, `github-actions`]
			: [`dot`],
		restoreMocks: true,
	},
});
