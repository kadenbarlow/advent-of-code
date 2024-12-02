export default function createObjectWithDefault(obj, defaultValue) {
  return new Proxy(obj, {
    get: (obj, key) => obj[key] ?? defaultValue,
  })
}
