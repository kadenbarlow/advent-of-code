import assert from "node:assert"
import getIndexFromArray from "./get-index-from-array.js"
import insertIntoArray from "./insert-into-array.js"
import removeFromArray from "./remove-from-array.js"
import sliceArray from "./slice-array.js"

const array1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
assert.strictEqual(getIndexFromArray(array1, 0), 0)
assert.strictEqual(getIndexFromArray(array1, 11), 0)
assert.deepEqual(sliceArray(array1, 0, 3), [0, 1, 2])
assert.deepEqual(sliceArray(array1, -3, 3), [8, 9, 10, 0, 1, 2])
assert.deepEqual(sliceArray(array1, -3, -1), [8, 9])
assert.deepEqual(sliceArray(array1, -3), [8, 9, 10])
assert.deepEqual(sliceArray(array1, -3, 0), [8, 9, 10])
assert.deepEqual(sliceArray(array1, -1, 5), [10, 0, 1, 2, 3, 4])
assert.deepEqual(sliceArray(array1, -3, 20), [8, 9, 10, 0, 1, 2, 3, 4, 5, 6, 7, 8])

const array2 = []
insertIntoArray(array2, 0, 1)
assert.deepEqual(array2, [1])
insertIntoArray(array2, 0, 0)
assert.deepEqual(array2, [0, 1])
insertIntoArray(array2, 2, 2)
assert.deepEqual(array2, [0, 1, 2])
insertIntoArray(array2, -1, -1)
assert.deepEqual(array2, [0, 1, -1, 2])

const array3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
removeFromArray(array3, -1)
assert.deepEqual(array3, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
removeFromArray(array3, 10)
assert.deepEqual(array3, [1, 2, 3, 4, 5, 6, 7, 8, 9])
