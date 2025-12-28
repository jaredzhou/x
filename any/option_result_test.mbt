///|
test "option some roundtrip" {
  let opt : Option[Int] = Some(42)
  let result : Option[Int] = from_any(to_any(opt))
  assert_eq(result, Some(42))
}

///|
test "option none roundtrip" {
  let opt : Option[Int] = None
  let result : Option[Int] = from_any(to_any(opt))
  assert_eq(result, None)
}

///|
test "option string roundtrip" {
  let opt : Option[String] = Some("hello")
  let result : Option[String] = from_any(to_any(opt))
  assert_eq(result, Some("hello"))
}

///|
test "result ok roundtrip" {
  let res : Result[Int, String] = Ok(42)
  let result : Result[Int, String] = from_any(to_any(res))
  assert_eq(result, Ok(42))
}

///|
test "result err roundtrip" {
  let res : Result[Int, String] = Err("error message")
  let result : Result[Int, String] = from_any(to_any(res))
  assert_eq(result, Err("error message"))
}
