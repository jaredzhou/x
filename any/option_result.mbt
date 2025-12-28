pub impl[T:FromAny] FromAny for T? with from_any(x : Any) -> Option[T] raise AnyDecodeError {
  match x {
    Any::None => None
    t => {
      Some(FromAny::from_any(t))
    }
  }
}

pub impl[T:ToAny] ToAny for T? with to_any(self : Option[T]) -> Any {
  match self {
    None => Any::None
    Some(value) => ToAny::to_any(value) 
  }
}

pub impl[T:FromAny, E:FromAny] FromAny for Result[T, E] with from_any(x : Any) -> Result[T, E] raise AnyDecodeError {
  match x {
    Any::Array(arr) => {
      guard arr is [tag, value] else {
        raise AnyDecodeError("expected 2-element array for Result[T, E]")
      }
      match tag {
        Any::Bool(true) => Ok(FromAny::from_any(value))
        Any::Bool(false) => Err(FromAny::from_any(value))
        _ => raise AnyDecodeError("expected Bool as first element")
      }
    }
    _ => raise AnyDecodeError("expected Result")
  }
}

pub impl[T:ToAny, E:ToAny] ToAny for Result[T, E] with to_any(self : Result[T, E]) -> Any {
  match self {
    Ok(v) => {
      ToAny::to_any((true, v))
    }
    Err(e) => {
     
      ToAny::to_any((false, e))
    }
  }
}