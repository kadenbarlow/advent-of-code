import wrapIndex from "./shared/wrap-index.js"

export default function sliceArray(array, start, end) {
  if (!end) {
    return array.slice(wrapIndex(array, start))
  } else if ((start >= 0 && end >= 0) || (start < 0 && end < 0)) {
    return array.slice(wrapIndex(array, start), wrapIndex(array, end))
  } else if (start < 0 && end >= 0) {
    return array.slice(wrapIndex(array, start)).concat(array.slice(0, wrapIndex(array, end)))
  } else if (start >= 0 && end < 0) {
    return array.slice(wrapIndex(array, start)).concat(array.slice(0, wrapIndex(array, end)))
  }
}
