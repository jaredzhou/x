pub impl[T: FromAny] FromAny for Array[T] with from_any(x : Any) -> Array[T] raise AnyDecodeError {
  match x {
    Any::Array(arr) => arr.map(item => FromAny::from_any(item))
    _ => raise AnyDecodeError("expected Array")
  }
}

pub impl[T: FromAny] FromAny for FixedArray[T] with from_any(x : Any) -> FixedArray[T] raise AnyDecodeError {
  match x {
  
    Any::Array(value) => FixedArray::from_array(value.map(item => FromAny::from_any(item)))
    _ => raise AnyDecodeError("expected Array")
  }
}
pub impl[T: ToAny] ToAny for Array[T] with to_any(self : Array[T]) -> Any {
  Any::Array(self.map(item => ToAny::to_any(item)))
}

pub impl[T: ToAny] ToAny for FixedArray[T] with to_any(self : FixedArray[T]) -> Any {
  Any::Array(self.iter().map(item => ToAny::to_any(item)).collect())
}

pub impl[T: ToAny] ToAny for ArrayView[T] with to_any(self : ArrayView[T]) -> Any {
  Any::Array(self.map(item => ToAny::to_any(item)))
}

// ArrayView[T] - only ToAny, no FromAny since ArrayView cannot be constructed directly
