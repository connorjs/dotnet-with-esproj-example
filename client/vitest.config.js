import path from "node:path";

import { defineConfig } from "vitest/config";

const workspaceRoot = path.resolve(import.meta.dirname, `..`);
const projectRoot = process.cwd();
const projectName = path.basename(projectRoot);

export default defineConfig({
	test: {
		coverage: {
			all: true,
			clean: false, // Workspace-wide coverage directory; do not clean
			provider: `v8`,
			// Coverage reporter
			reporter: [[`cobertura`, { file: `${projectName}.cobertura.xml` }]],
			reportsDirectory: `${workspaceRoot}/coverage`,
			thresholds: {
				branches: 80,
				functions: 80,
				lines: 80,
				perFile: true,
			},
		},
		// Unit test reporter (not coverage)
		reporters: process.env.GITHUB_ACTIONS ? ["dot", "github-actions"] : ["dot"],
		restoreMocks: true,
	},
});
