pub impl[U : ToAny, V : ToAny] ToAny for (U, V) with to_any(self : (U, V)) -> Any {
  let (first, second) = self
  Any::Array([ToAny::to_any(first), ToAny::to_any(second)])
}

pub impl[U:ToAny, V:ToAny, W:ToAny] ToAny for (U, V, W) with to_any(self : (U, V, W)) -> Any {
  let (first, second, third) = self
  Any::Array([ToAny::to_any(first), ToAny::to_any(second), ToAny::to_any(third)])
}

pub impl[U:ToAny, V:ToAny, W:ToAny, X:ToAny] ToAny for (U, V, W, X) with to_any(self : (U, V, W, X)) -> Any {
  let (first, second, third, fourth) = self
  Any::Array([ToAny::to_any(first), ToAny::to_any(second), ToAny::to_any(third), ToAny::to_any(fourth)])
}

pub impl[U:FromAny, V:FromAny] FromAny for (U, V) with from_any(x : Any) -> (U, V) raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      guard arr is [first, second] else {
        raise AnyDecodeError("expected 2-element array for tuple (U, V)")
      }
      (FromAny::from_any(first), FromAny::from_any(second))
    }
    _ => raise AnyDecodeError("expected array for tuple (U, V)")
  }
}

pub impl[U:FromAny, V:FromAny, W:FromAny] FromAny for (U, V, W) with from_any(x : Any) -> (U, V, W) raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      guard arr is [first, second, third] else {
        raise AnyDecodeError("expected 3-element array for tuple (U, V, W)")
      }
      (FromAny::from_any(first), FromAny::from_any(second), FromAny::from_any(third))
    }
    _ => raise AnyDecodeError("expected array for tuple (U, V, W)")
  }
}

pub impl[U:FromAny, V:FromAny, W:FromAny, X:FromAny] FromAny for (U, V, W, X) with from_any(x : Any) -> (U, V, W, X) raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      guard arr is [first, second, third, fourth] else {
        raise AnyDecodeError("expected 4-element array for tuple (U, V, W, X)")
      }
      (FromAny::from_any(first), FromAny::from_any(second), FromAny::from_any(third), FromAny::from_any(fourth))
    }
    _ => raise AnyDecodeError("expected array for tuple (U, V, W, X)")
  }
}
