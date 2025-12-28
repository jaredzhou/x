///|
test "tuple2 roundtrip" {
  assert_eq(from_any(to_any(("hello", 42))), ("hello", 42))
  assert_eq(from_any(to_any((true, false))), (true, false))
  assert_eq(from_any(to_any((1.5, "test"))), (1.5, "test"))
}

///|
test "tuple3 roundtrip" {
  assert_eq(from_any(to_any(("a", "b", "c"))), ("a", "b", "c"))
  assert_eq(from_any(to_any((1, 2, 3))), (1, 2, 3))
  assert_eq(from_any(to_any((true, false, true))), (true, false, true))
}

///|
test "tuple4 roundtrip" {
  assert_eq(from_any(to_any((1, 2, 3, 4))), (1, 2, 3, 4))
  assert_eq(from_any(to_any(("a", "b", "c", "d"))), ("a", "b", "c", "d"))
  assert_eq(from_any(to_any((true, false, true, false))), (true, false, true, false))
}
