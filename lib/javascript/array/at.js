import wrapIndex from "./shared/wrap-index.js"

export default function at(array, index) {
  if (array[index]) return array[index]
  else return array[wrapIndex(array, index)]
}
