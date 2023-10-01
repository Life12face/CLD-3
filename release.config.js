module.exports = {
    branches: "main",
    repositoryUrl: "https://github.com/Life12face/CLD-3.git",
    plugins: [
      '@semantic-release/commit-analyzer',
      '@semantic-release/release-notes-generator',
      '@semantic-release/git',
      '@semantic-release/github']
 }