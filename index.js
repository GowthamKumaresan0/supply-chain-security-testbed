// Minimal demo entry point
function greet(name) {
  return `Hello, ${name || "world"}!`;
}

if (require.main === module) {
  console.log(greet("Supply Chain Guardian"));
}

module.exports = { greet };
