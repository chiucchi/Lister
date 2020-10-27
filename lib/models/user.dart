class User {
  int id;
  String name;
  String username;
  String password;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['username'] = username;
    mapping['password'] = password;

    return mapping;
  }
}
