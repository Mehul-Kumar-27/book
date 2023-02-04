class GroupModel {
  late String category;
  late String admin;
  late String authorName;
  late String bookName;
  late String description;
  late String groupId;
  late String bookUrl;

  GroupModel(
      {required this.category,
      required this.admin,
      required this.bookName,
      required this.description,
      required this.groupId,
      required this.authorName,
      required this.bookUrl});

  GroupModel.fromJson(Map<String, dynamic> json) {
    category = json["category"];
    admin = json["admin"];
    authorName = json["authorName"];
    bookName = json["bookName"];
    description = json["description"];
    groupId = json["groupId"];
    bookUrl = json["bookUrl"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["category"] = category;
    data["admin"] = admin;
    data["authorName"] = authorName;
    data["bookName"] = bookName;
    data["description"] = description;
    data["groupId"] = groupId;
    data["bookUrl"] = bookUrl;

    return data;
  }
}
