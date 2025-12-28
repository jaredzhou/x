// Map[K, V] - stored as Array of (key, value) pairs
pub impl[K: ToAny, V: ToAny] ToAny for Map[K, V] with to_any(self : Map[K, V]) -> Any {
  let arr: Array[(Any, Any)] = Array::make(self.length(), (None, None))
  let mut  i = 0
   for k, v in self {
      arr.set(i, (ToAny::to_any(k), ToAny::to_any(v)))
      i = i + 1
    }
  Any::Map(arr)
}

pub impl[K: FromAny + Eq + Hash, V: FromAny] FromAny for Map[K, V] with from_any(x : Any) -> Map[K, V] raise AnyDecodeError {
  match x {
    Any::Map(arr) => {
      let m = {}
      for elem in  arr {  
        let (k, v) = elem
        let (k, v) = (FromAny::from_any(k), FromAny::from_any(v))
        m[k] = v  // duplicate keys: last wins
      }
      m
    }
    _ => raise AnyDecodeError("expected Map for Map[K, V]")
  }
}
