export default function createObjectWithDefault(obj, defaultValue) {
  return new Proxy(obj, {
    get: (obj, key) => {
      if (obj.hasOwnProperty(key)) return obj[key]
      obj[key] = typeof defaultValue === "function" ? defaultValue(key) : defaultValue

      return obj[key]
    },
  })
}
