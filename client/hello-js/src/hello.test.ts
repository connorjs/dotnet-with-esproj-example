import { describe, expect, it } from "vitest";

import { hello } from "./hello.ts";

describe(`hello`, () => {
	it.each([
		[undefined, `Hello, world!`],
		[``, `Hello, world!`],
		[` `, `Hello,  !`],
		[`foo`, `Hello, foo!`],
	])(`should map [%s] to [%s]`, (input, expected) => {
		expect(hello(input)).toStrictEqual(expected);
	});

	it(`does not require an argument`, () => {
		expect(hello()).toBe(`Hello, world!`);
	});
});
