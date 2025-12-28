// Unit
pub impl ToAny for Unit with to_any(_ : Unit) -> Any {
  Any::Unit
}

pub impl FromAny for Unit with from_any(x : Any) -> Unit raise AnyDecodeError {
  match x {
    Any::Unit => ()
    _ => raise AnyDecodeError("expected Unit")
  }
}

// Bool
pub impl ToAny for Bool with to_any(self : Bool) -> Any {
  Any::Bool(self)
}

pub impl FromAny for Bool with from_any(x : Any) -> Bool raise AnyDecodeError {
  match x {
    Any::Bool(value) => value
    _ => raise AnyDecodeError("expected Bool")
  }
}

// Int
pub impl ToAny for Int with to_any(self : Int) -> Any {
  Any::Int(self.to_int64())
}

pub impl FromAny for Int with from_any(x : Any) -> Int raise AnyDecodeError {
  match x {
    Any::Int(value) => value.to_int()
    _ => raise AnyDecodeError("expected Int")
  }
}

// Int64
pub impl ToAny for Int64 with to_any(self : Int64) -> Any {
  Any::Int(self)
}

pub impl FromAny for Int64 with from_any(x : Any) -> Int64 raise AnyDecodeError {
  match x {
    Any::Int(value) => value
    _ => raise AnyDecodeError("expected Int")
  }
}

// UInt
pub impl ToAny for UInt with to_any(self : UInt) -> Any {
  Any::Int(self.to_int64())
}

pub impl FromAny for UInt with from_any(x : Any) -> UInt raise AnyDecodeError {
  match x {
    Any::Int(value) => value.reinterpret_as_uint64().to_uint()
    _ => raise AnyDecodeError("expected UInt")
  }
}

// UInt64
pub impl ToAny for UInt64 with to_any(self : UInt64) -> Any {
  Any::Int(self.reinterpret_as_int64())
}

pub impl FromAny for UInt64 with from_any(x : Any) -> UInt64 raise AnyDecodeError {
  match x {
    Any::Int(value) => value.reinterpret_as_uint64()
    _ => raise AnyDecodeError("expected UInt64")
  }
}

// BigInt
pub impl ToAny for BigInt with to_any(self : BigInt) -> Any {
  Any::String(self.to_string())
}

pub impl FromAny for BigInt with from_any(x : Any) -> BigInt raise AnyDecodeError {
  match x {
    Any::String(value) => BigInt::from_string(value)
    _ => raise AnyDecodeError("expected String")
  }
}

// Double
pub impl ToAny for Double with to_any(self : Double) -> Any {
  Any::Double(self)
}

pub impl FromAny for Double with from_any(x : Any) -> Double raise AnyDecodeError {
  match x {
    Any::Double(value) => value
    _ => raise AnyDecodeError("expected Double")
  }
}

// String
pub impl ToAny for String with to_any(self : String) -> Any {
  Any::String(self)
}

pub impl FromAny for String with from_any(x : Any) -> String raise AnyDecodeError {
  match x {
    Any::String(value) => value
    _ => raise AnyDecodeError("expected String")
  }
}

// Bytes
pub impl ToAny for Bytes with to_any(self : Bytes) -> Any {
  Any::Bytes(self)
}

pub impl FromAny for Bytes with from_any(x : Any) -> Bytes raise AnyDecodeError {
  match x {
    Any::Bytes(value) => value
    _ => raise AnyDecodeError("expected Bytes")
  }
}

// Char - stored as Int
pub impl ToAny for Char with to_any(self : Char) -> Any {
  Any::Int(self.to_int().to_int64())
}

pub impl FromAny for Char with from_any(x : Any) -> Char raise AnyDecodeError {
  match x {
    Any::Int(value) => {
      if  value.to_uint16().to_char() is Some(c) {
        c
      } else {
        raise AnyDecodeError("invalid Char value")
      }
    }
    _ => raise AnyDecodeError("expected Int")
  }
}

// Byte - stored as Int
pub impl ToAny for Byte with to_any(self : Byte) -> Any {
  Any::Byte(self)
}

pub impl FromAny for Byte with from_any(x : Any) -> Byte raise AnyDecodeError {
  match x {
    Any::Byte(value) => value
    _ => raise AnyDecodeError("expected Int")
  }
}

// Float - stored as Double
pub impl ToAny for Float with to_any(self : Float) -> Any {
  Any::Double(self.to_double())
}

pub impl FromAny for Float with from_any(x : Any) -> Float raise AnyDecodeError {
  match x {
    Any::Double(value) => Float::from_double(value)
    _ => raise AnyDecodeError("expected Double")
  }
}

// Int16 - stored as Int
pub impl ToAny for Int16 with to_any(self : Int16) -> Any {
  Any::Int(self.to_int64())
}

pub impl FromAny for Int16 with from_any(x : Any) -> Int16 raise AnyDecodeError {
  match x {
    Any::Int(value) => Int16::from_int64(value)
    _ => raise AnyDecodeError("expected Int")
  }
}

// UInt16 - stored as Int
pub impl ToAny for UInt16 with to_any(self : UInt16) -> Any {
  Any::Int(self.to_int64())
}

pub impl FromAny for UInt16 with from_any(x : Any) -> UInt16 raise AnyDecodeError {
  match x {
    Any::Int(value) => value.to_uint16()
    _ => raise AnyDecodeError("expected Int")
  }
}
