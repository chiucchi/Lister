class User {
  int id;
  String name;
  String username;
  String password;

  User(this.id, this.name, this.username, this.password);

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['username'] = username;
    mapping['password'] = password;

    return mapping;
  }

  User.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.username = obj['username'];
    this.password = obj['password'];
  }


}
