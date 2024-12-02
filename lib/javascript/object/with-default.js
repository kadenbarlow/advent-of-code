export default function withDefault(obj, defaultValue) {
  return new Proxy(obj, {
    get: (obj, key) => obj[key] ?? defaultValue,
  })
}
