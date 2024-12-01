export default function objectWithDefault(obj, defaultValue) {
  return new Proxy(obj, {
    get: (obj, key) => obj[key] ?? defaultValue,
  })
}
