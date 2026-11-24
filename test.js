const assert = require("assert");
const { greet } = require("./index");

assert.strictEqual(greet("Guardian"), "Hello, Guardian!");
console.log("All unit tests passed.");
