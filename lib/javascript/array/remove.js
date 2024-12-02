import wrapIndex from "./shared/wrap-index.js"

export default function remove(array, index) {
  array.splice(wrapIndex(array, index), 1)
}
