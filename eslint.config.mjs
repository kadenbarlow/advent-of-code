import eslintPluginPerfectionist from "eslint-plugin-perfectionist"
import eslintPluginSortDestructureKeys from "eslint-plugin-sort-destructure-keys"

export default [
  {
    plugins: {
      perfectionist: eslintPluginPerfectionist,
      "sort-destructure-keys": eslintPluginSortDestructureKeys,
    },
    rules: {
      "no-debugger": "error",
      "perfectionist/sort-named-exports": "error",
      "perfectionist/sort-objects": "error",
      "sort-destructure-keys/sort-destructure-keys": "error",
    },
  },
]
