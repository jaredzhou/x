///|
test "array of any roundtrip" {
  let arr = [1,2,3]
  let result = from_any(to_any(arr))
  assert_eq(arr, result)
 
}

///|
test "fixedarray of any roundtrip" {
  let arr = FixedArray::from_array([1,2,3])
  let result = from_any(to_any(arr))
  assert_eq(arr, result)
 
}

///|
test "arrayview of int to_any" {
  let arr  = [1,2,3][:]
  let encoded = from_any(to_any(arr))
  // Verify it's encoded as Array[Any]
  assert_eq(encoded, [1,2,3])
}
