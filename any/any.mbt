/// A type container that can hold values of various types.

pub(all) suberror AnyDecodeError String derive(Show)

/// The `Any` type can represent various data types.
pub(all) enum Any {
  Unit
  None
  Bool(Bool)
  Byte(Byte)
  Int(Int64)
  Double(Double)
  String(String)
  Bytes(Bytes)
  Array(Array[Any])
  Map(Array[(Any, Any)])
  Struct(Array[(String, Any)]) 
} derive(Show)

/// Trait for converting a value to `Any`.
pub(open) trait ToAny {
  to_any(Self) -> Any
}

/// Trait for converting from `Any` to a specific type.
pub(open) trait FromAny {
  from_any(Any) -> Self raise AnyDecodeError
}

pub fn[T:ToAny] to_any(value : T) -> Any {
  ToAny::to_any(value)
}

pub fn[T:FromAny] from_any(x : Any) -> T raise AnyDecodeError {
  FromAny::from_any(x)
}

pub fn[K:Eq+ToAny+FromAny, V:ToAny+FromAny] Any::map_set(x : Any, key : K, value : V) -> V? raise AnyDecodeError {
  match x {
    Any::Map(arr) => {
      for i, elem in arr {
        let (k, v) = elem
        let  k_origin: K = FromAny::from_any(k)
        if k_origin == key {
         let new_v = ToAny::to_any(value)
          arr.set(i, (k, new_v))
          return FromAny::from_any(v)
        } 
      } else {
        arr.push((ToAny::to_any(key), ToAny::to_any(value)))
        return None
      }
    }
    _ => raise AnyDecodeError("expected Map for map_set")
  }
}

pub fn[K:Eq+FromAny, V:FromAny] Any::map_get(x : Any, key : K) -> V? raise AnyDecodeError {
  match x {
    Any::Map(arr) => {
      for elem in arr {
        let (k, v) = elem
        let  k_origin: K = FromAny::from_any(k)
        if k_origin == key {
          return FromAny::from_any(v)
        } 
      }
      None
    }
    _ => raise AnyDecodeError("expected Map for map_get")
  }
}

pub fn[K:Eq+FromAny, V:FromAny] Any::map_delete(x : Any, key: K) -> V? raise AnyDecodeError {
  match x {
    Any::Map(arr) => {
      for i, elem in arr {
        let (k, v) = elem
        let  k_origin: K = FromAny::from_any(k)
        if k_origin == key {
          arr.remove(i) |> ignore
          return FromAny::from_any(v)
        } 
      } else {
        None
      }
    }
    _ => raise AnyDecodeError("expected Map for map_delete")
  }
}

pub fn Any::map_length(x : Any) -> Int raise AnyDecodeError {
  match x {
    Any::Map(arr) => {
      arr.length()
    }
    _ => raise AnyDecodeError("expected Map for map_length")
  }
}


pub fn [T: ToAny] Any::array_push(x : Any, value : T) -> Unit raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      arr.push(ToAny::to_any(value))
    }
    _ => raise AnyDecodeError("expected Array for array_push")
  }
}

pub fn[T: FromAny]  Any::array_delete(x : Any, i: Int) -> T raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      arr.remove(i) |> FromAny::from_any()
    }
    _ => raise AnyDecodeError("expected Array for array_delete")
  }
}

pub fn[T: FromAny] Any::array_get(x : Any, i: Int) -> T raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      arr[i] |> FromAny::from_any()
    }
    _ => raise AnyDecodeError("expected Array for array_get")
  }
}

pub fn Any::array_length(x : Any) -> Int raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      arr.length()
    }
    _ => raise AnyDecodeError("expected Array for array_length")
  }
}

pub fn[T: ToAny] Any::array_set(x : Any, i: Int, value : T) -> Unit raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      arr.set(i, ToAny::to_any(value))
    }
    _ => raise AnyDecodeError("expected Array for array_set")
  }
}

pub fn[V: ToAny] Any::struct_update(x : Any, key: String, value : V) -> Unit raise AnyDecodeError {
  match x {
    Any::Struct(arr) => {
      for i, elem in arr{
        let (k, _) = elem
        if k  == key {
          arr.set(i, (k, ToAny::to_any(value)))
          return
        }
      } else {
        raise AnyDecodeError("key not found in struct " + key)
      }
    }
    _ => raise AnyDecodeError("expected Map for struct_update")
  }
}