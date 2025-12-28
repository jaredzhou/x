struct UserInfo {
  user_id: String
  age: Int
  is_admin: Bool
  groups: Array[String]
} derive(Show, ToJson)

impl ToAny for UserInfo with to_any(self : UserInfo) -> Any {
  let array : Array[(String, Any)] = [
    ("user_id", ToAny::to_any(self.user_id)),
    ("age", ToAny::to_any(self.age)),
    ("is_admin", ToAny::to_any(self.is_admin)),
    ("groups", ToAny::to_any(self.groups))
  ]
  Struct(array)
}

impl FromAny for UserInfo with from_any(x : Any) -> UserInfo raise AnyDecodeError {
  guard x is Any::Struct(arr) else {
    raise @any.AnyDecodeError("expected Struct for UserInfo")
  }

  UserInfo::{
    user_id: FromAny::from_any(arr[0].1),
    age: FromAny::from_any(arr[1].1),
    is_admin: FromAny::from_any(arr[2].1),
    groups: FromAny::from_any(arr[3].1)
  }
}

test "struct update" {
  let user = UserInfo::{
    user_id: "user123",
    age: 30,
    is_admin: false,
    groups: ["users", "editors"]
  }
  let info : Any = to_any(user)

  Any::struct_update(info, "age", 31)
  Any::struct_update(info, "is_admin", true)
  Any::struct_update(info, "groups", ["users", "editors", "admins"])

  let updated_info : UserInfo = from_any(info)

  assert_eq(updated_info.age, 31)
  assert_eq(updated_info.is_admin, true)
  assert_eq(updated_info.groups, ["users", "editors", "admins"])
}