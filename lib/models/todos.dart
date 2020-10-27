class Todo {
  int id;
  String title;
  String description;
  String category;
  int isFinished;
  int userid;

  todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = description;
    mapping['category'] = category;
    mapping['isFinished'] = isFinished;
    mapping['userid'] = userid;

    return mapping;
  }
}
