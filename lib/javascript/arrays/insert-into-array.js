import wrapIndex from "./shared/wrap-index.js"

export default function insertIntoArray(array, index, value) {
  array.splice(index < 0 ? wrapIndex(array, index) : index, 0, value)
}
