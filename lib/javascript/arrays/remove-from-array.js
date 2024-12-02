import wrapIndex from "./shared/wrap-index.js"

export default function removeFromArray(array, index) {
  array.splice(wrapIndex(array, index), 1)
}
