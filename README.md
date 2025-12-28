# jaredzhou/x

Extended packages for web application development.

## Packages

### @jaredzhou/x/any

Type-erased value containers and bidirectional conversion between MoonBit types and `Any` values.

```mbt
let value = 42
let any_val = to_any(value)
let restored : Int = from_any(any_val)
// restored == 42
```

**Features:**
- `ToAny` trait for converting values to `Any`
- `FromAny` trait for converting `Any` back to specific types
- Support for basic types, ararys, maps,  tuples, Option and Result 
- Support customized struct by impl `ToAny` and `FromAny` trait
- Support direct update operation on `Any::Array`, `Any::Map` And `Any::Struct`

[Read more](./any/README.mbt.md)

### @jaredzhou/x/url

URL parsing according to RFC 3986. pass test from golang standard library

```mbt
let url = parse("http://example.com/path?query=1")?
assert_eq(url.scheme, Some("http"))
assert_eq(url.host, Some("example.com"))
```

**Features:**
- URL parsing and serialization
- Query string encoding/decoding
- Path segment encoding/decoding
- Request URI validation
- IPv6 address support

[Read more](./url/README.mbt.md)

## Usage
To use a package from this repository, add module moonbitlang/x to dependencies by command
```bash
moon add moonbitlang/x
```
Add to your `moon.mod.json`:

```json
{
  "import": ["jaredzhou/x/any", "jaredzhou/x/url"]
}
```

## License

Apache-2.0
