///|
test "unit roundtrip" {
  assert_eq(from_any(to_any(())), ())
}

///|
test "bool roundtrip" {
  assert_eq(from_any(to_any(true)), true)
  assert_eq(from_any(to_any(false)), false)
}

///|
test "int roundtrip" {
  assert_eq(from_any(to_any(42)), 42)
  assert_eq(from_any(to_any(-123)), -123)
  assert_eq(from_any(to_any(0)), 0)
}

///|
test "int64 roundtrip" {
  let v = 9999999999L
  assert_eq(from_any(to_any(v)), v)
  let v2 = (-1).to_int64()
  assert_eq(from_any(to_any(v2)), v2)
}

///|
test "uint roundtrip" {
  assert_eq(from_any(to_any(100)), 100)
}

///|
test "uint64 roundtrip" {
  let v = 18446744073709551615UL
  assert_eq(from_any(to_any(v)), v)
}

///|
test "double roundtrip" {
  assert_eq(from_any(to_any(3.14)), 3.14)
  assert_eq(from_any(to_any(-0.5)), -0.5)
}

///|
test "string roundtrip" {
  assert_eq(from_any(to_any("hello")), "hello")
  assert_eq(from_any(to_any("")), "")
  assert_eq(from_any(to_any("你好世界")), "你好世界")
}

///|
test "bytes roundtrip" {
  let b = Bytes::from_array([1, 2, 3, 4, 5])
  assert_eq(from_any(to_any(b)), b)
}

///|
test "char roundtrip" {
  assert_eq(from_any(to_any('a')), 'a')
  assert_eq(from_any(to_any('中')), '中')
  assert_eq(from_any(to_any('0')), '0')
}

///|
test "byte roundtrip" {
  assert_eq(from_any(to_any(b'a')), b'a')
  assert_eq(from_any(to_any(b' ')), b' ')
}

///|
test "float roundtrip" {
  let f = Float::from_double(3.14)
  assert_eq(from_any(to_any(f)), f)
}

///|
test "int16 roundtrip" {
  assert_eq(from_any(to_any(Int16::from_int(32767))), Int16::from_int(32767))
  assert_eq(from_any(to_any(Int16::from_int(-32768))), Int16::from_int(-32768))
}

///|
test "uint16 roundtrip" {
  assert_eq(from_any(to_any((65535:UInt16))), (65535:UInt16))
}
