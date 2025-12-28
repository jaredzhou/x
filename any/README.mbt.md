# `any`

The `any` package provides unified value container `Any`  and bidirectional conversion
between MoonBit types and `Any` values.

## Core Types

### Any Enum

```mbt check
///|
test "any enum variants" {
  // Unit and None
  assert_eq(from_any(to_any(())), ())
  let opt : Option[Int] = None
  assert_eq(from_any(to_any(opt)), None)

  // Boolean
  assert_eq(from_any(to_any(true)), true)
  assert_eq(from_any(to_any(false)), false)

  // Numeric types
  assert_eq(from_any(to_any(42)), 42)
  assert_eq(from_any(to_any(3.14)), 3.14)

  // String and Bytes
  assert_eq(from_any(to_any("hello")), "hello")
  let b = Bytes::from_array([1, 2, 3])
  assert_eq(from_any(to_any(b)), b)
}
```

### ToAny and FromAny Traits

The `ToAny` trait converts values to `Any`, while `FromAny` converts `Any` back to
specific types with error handling.

```mbt check
///|
test "to_any and from_any" {
  let value = 42
  let any_val = to_any(value)
  let restored : Int = from_any(any_val)
  assert_eq(restored, 42)
}
```

## Supported Types

### Basic Types

```mbt check
///|
test "basic types roundtrip" {
  // Integer types
  assert_eq(from_any(to_any(42)), 42)
  assert_eq(from_any(to_any(9999999999L)), 9999999999L)
  let u : UInt = 100
  assert_eq(from_any(to_any(u)), 100)
  let u16 : UInt16 = 65535
  assert_eq(from_any(to_any(u16)), u16)

  // Floating point
  let f = Float::from_double(3.14)
  assert_eq(from_any(to_any(f)), f)

  // Character
  assert_eq(from_any(to_any('a')), 'a')
  assert_eq(from_any(to_any('中')), '中')

  // Byte
  assert_eq(from_any(to_any(b'a')), b'a')
}
```

### Collections

```mbt check
///|
test "collections roundtrip" {
  // Array
  let arr = [1, 2, 3]
  assert_eq(from_any(to_any(arr)), arr)

  // FixedArray
  let fixed = FixedArray::from_array([1, 2, 3])
  assert_eq(from_any(to_any(fixed)), fixed)

  // Map
  let m = Map::new()
  m["a"] = 1
  m["b"] = 2
  let result : Map[String, Int] = from_any(to_any(m))
  assert_eq(result["a"], 1)
  assert_eq(result["b"], 2)

  // Nested map
  let nested = Map::new()
  nested["outer"] = Map::new()
  nested["outer"]["inner"] = 42
  let result2 : Map[String, Map[String, Int]] = from_any(to_any(nested))
  assert_eq(result2["outer"]["inner"], 42)
}
```

### Tuples

```mbt check
///|
test "tuples roundtrip" {
  // 2-tuple
  assert_eq(from_any(to_any(("hello", 42))), ("hello", 42))

  // 3-tuple
  assert_eq(from_any(to_any((1, 2, 3))), (1, 2, 3))

  // 4-tuple
  assert_eq(from_any(to_any((true, false, true, false))), (true, false, true, false))
}
```

### Option and Result

```mbt check
///|
test "option and result roundtrip" {
  // Option
  assert_eq(from_any(to_any(Some(42))), Some(42))
  let opt : Option[Int] = None
  assert_eq(from_any(to_any(opt)), None)

  // Result
  assert_eq(from_any(to_any(Ok(42))), Ok(42))
  assert_eq(from_any(to_any(Err("error"))), Err("error"))
}
```

## Error Handling

### Decode Errors

```mbt check
///|
test "decode error handling" {
  // Type mismatch
  try {
    let _ : Int = from_any(to_any("not a number"))
    panic()
  } catch {
    AnyDecodeError(msg) => assert_true(msg.has_prefix("expected"))
  }

  // Array to Map conversion fails
  try {
    let _ : Map[String, Int] = from_any(to_any([1, 2, 3]))
    panic()
  } catch {
    AnyDecodeError(msg) => assert_eq(msg, "expected Map for Map[K, V]")
  }
}
```

## Any Methods

### Array Operations

```mbt check
///|
test "array operations" {
  let arr = [1, 2, 3]
  let any_arr = to_any(arr)

  // Get element
  let first : Int = Any::array_get(any_arr, 0)
  assert_eq(first, 1)

  // Get length
  let len = Any::array_length(any_arr)
  assert_eq(len, 3)

  // Push new element
  Any::array_push(any_arr, 4)
  assert_eq(Any::array_length(any_arr), 4)

  // Set element
  Any::array_set(any_arr, 0, 10)
  let new_first : Int = Any::array_get(any_arr, 0)
  assert_eq(new_first, 10)
}
```

### Map Operations

```mbt check
///|
test "map operations" {
  let m = Map::new()
  m["key1"] = "value1"
  m["key2"] = "value2"
  let any_map = to_any(m)

  // Get length
  let len = Any::map_length(any_map)
  assert_eq(len, 2)

  // Get value by key
  let val = match Any::map_get(any_map, "key1") {
    Some(v) => v
    None => panic()
  }
  assert_eq(val, "value1")

  // Set or update value
  let old = match Any::map_set(any_map, "key1", "new_value") {
    Some(v) => v
    None => panic()
  }
  assert_eq(old, "value1")

  // Delete value
  let deleted = match Any::map_delete(any_map, "key1") {
    Some(v) => v
    None => panic()
  }
  assert_eq(deleted, "new_value")
}
```

## Protocol

### Any Representation

- `Any::Unit` - Unit type
- `Any::None` - None/Null
- `Any::Bool(Bool)` - Boolean
- `Any::Byte(Byte)` - Byte (8-bit)
- `Any::Int(Int64)` - Integer (stored as Int64)
- `Any::Double(Double)` - Floating point
- `Any::String(String)` - String
- `Any::Bytes(Bytes)` - Byte array
- `Any::Array(Array[Any])` - Array of Any values
- `Any::Map(Array[(Any, Any)])` - Map as key-value pair array
- `Any::Struct(Array[(String, Any)])` - Struct as field array

### Duplicate Key Behavior

When constructing `Any::Map([(k, v1), (k, v2)])`, decoding results in `k -> v2`
(last value wins).

```mbt check
///|
test "duplicate keys last wins" {
  let m = Map::new()
  m["key"] = 1
  m["key"] = 2
  let result : Map[String, Int] = from_any(to_any(m))
  assert_eq(result["key"], 2) // last value wins
}
```
