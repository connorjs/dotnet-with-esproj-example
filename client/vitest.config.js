import path from "node:path";

import { defineConfig } from "vitest/config";

const vitestConfigRoot = import.meta.dirname;
const workspaceRoot = path.resolve(vitestConfigRoot, `..`);

const projectRoot = process.cwd();
const projectName = path.basename(projectRoot);

console.error({ vitestConfigRoot, workspaceRoot, projectRoot, projectName });

export default defineConfig({
	// server: { fs: { allow: [vitestFactoryRoot] } },
	test: {
		coverage: {
			all: true,
			clean: false, // Workspace-wide coverage directory; do not clean
			include: [projectRoot],
			provider: `v8`,
			reporter: [[`cobertura`, { file: `${projectName}.cobertura.xml` }]],
			reportsDirectory: `${workspaceRoot}/coverage`,
			thresholds: {
				branches: 80,
				functions: 80,
				lines: 80,
				perFile: true,
			},
		},
		reporters: [`dot`], // Unit test reporter (not coverage)
		restoreMocks: true,
	},
});
