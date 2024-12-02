import assert from "node:assert"
import { at, insert, remove, slice } from "./index.js"

const array1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
assert.strictEqual(at(array1, 0), 0)
assert.strictEqual(at(array1, 11), 0)
assert.deepEqual(slice(array1, 0, 3), [0, 1, 2])
assert.deepEqual(slice(array1, -3, 3), [8, 9, 10, 0, 1, 2])
assert.deepEqual(slice(array1, -3, -1), [8, 9])
assert.deepEqual(slice(array1, -3), [8, 9, 10])
assert.deepEqual(slice(array1, -3, 0), [8, 9, 10])
assert.deepEqual(slice(array1, -1, 5), [10, 0, 1, 2, 3, 4])
assert.deepEqual(slice(array1, -3, 20), [8, 9, 10, 0, 1, 2, 3, 4, 5, 6, 7, 8])

const array2 = []
insert(array2, 0, 1)
assert.deepEqual(array2, [1])
insert(array2, 0, 0)
assert.deepEqual(array2, [0, 1])
insert(array2, 2, 2)
assert.deepEqual(array2, [0, 1, 2])
insert(array2, -1, -1)
assert.deepEqual(array2, [0, 1, -1, 2])

const array3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
remove(array3, -1)
assert.deepEqual(array3, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
remove(array3, 10)
assert.deepEqual(array3, [1, 2, 3, 4, 5, 6, 7, 8, 9])
