export default function wrapIndex(array, index) {
  return ((index % array.length) + array.length) % array.length
}
