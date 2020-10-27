class Category {
  int id;
  String name;
  String description;
  int userid;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;
    mapping['userid'] = userid;

    return mapping;
  }
}
