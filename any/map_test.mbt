///|
test "map string to int roundtrip" {
  let m = Map::new()
  m["a"] = 1
  m["b"] = 2
  m["c"] = 3
  let result: Map[String, Int] = from_any(to_any(m))
  assert_eq(result["a"], 1)
  assert_eq(result["b"], 2)
  assert_eq(result["c"], 3)
}

///|
test "map int to string roundtrip" {
  let m = Map::new()
  m[1] = "one"
  m[2] = "two"
  m[3] = "three"
  let result: Map[Int, String] = from_any(to_any(m))
  assert_eq(result[1], "one")
  assert_eq(result[2], "two")
  assert_eq(result[3], "three")
}

///|
test "empty map roundtrip" {
  let m : Map[String, Int] = Map::new()
  let result : Map[String, Int] = from_any(to_any(m))
  assert_eq(result.length(), 0)
}

///|
test "duplicate keys - last value wins" {
  // Create map with duplicate keys and verify last value wins
  let arr = [(to_any("key"), to_any(1)),
                  (to_any("key"), to_any(2)),]
  let result: Map[String, Int] = from_any(Any::Map(arr))
  assert_eq(result["key"], 2) // last value wins
}

///|
test "map nested roundtrip" {
  let m = Map::new()
  m["outer"] = Map::new()
  m["outer"]["inner"] = 42
  let result: Map[String, Map[String, Int]] = from_any(to_any(m))
  assert_eq(result["outer"]["inner"], 42)
}
