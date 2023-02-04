import 'package:flutter/material.dart';

class Chats {
  late String username;
  late String date;
  late String chatId;
  late String description;

  Chats({
    required this.username,
    required this.date,
    required this.description,
    required this.chatId,
  });

  Chats.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    date = json["date"];
    chatId = json["chatId"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["username"] = username;
    data["date"] = date;
    data["chatId"] = chatId;
    data["description"] = description;

    return data;
  }
}
