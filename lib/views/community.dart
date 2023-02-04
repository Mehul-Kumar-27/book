// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:book/models/group.dart';

import '../models/chats.dart';

class Community extends StatefulWidget {
  GroupModel model;
  Community({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  FocusNode _textFieldFocusNode = FocusNode();
  TextEditingController message = TextEditingController();
  Stream? chats;
  Future<Stream<QuerySnapshot>> getChats() async {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(widget.model.groupId)
        .collection("chats")
        .orderBy("chatId", descending: false)
        .snapshots();
  }

  getAllChats() {
    getChats().then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: chats,
                builder: (context, AsyncSnapshot snapshot) {
                  return !snapshot.hasData
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            Chats model = Chats.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>);
                            return GestureDetector(
                              onTap: () {},
                              child: ChatModel(
                                model: model,
                              ),
                            );
                          });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: message,
                    focusNode: _textFieldFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter your message here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await uploadMessage().then((value) {
                        message.clear();
                      });
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String chatId = DateTime.now().millisecondsSinceEpoch.toString();
  Future uploadMessage() async {
    FirebaseFirestore.instance
        .collection("groups")
        .doc(widget.model.groupId)
        .collection("chats")
        .add({
      "username": sharedPreferences!.getString("name"),
      "date": formattedDate,
      "description": message.text,
      "chatId": chatId
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }
}

class ChatModel extends StatefulWidget {
  Chats model;
  ChatModel({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ChatModel> createState() => _ChatModelState();
}

class _ChatModelState extends State<ChatModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.model.username.text
              .textStyle(
                  GoogleFonts.poppins(fontSize: 10, color: Colors.purple[800]))
              .overflow(TextOverflow.clip)
              .make()
              .px8(),
          Center(
            child: Row(
              children: [
                Flexible(
                    child: widget.model.description.text
                        .textStyle(GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500))
                        .overflow(TextOverflow.clip)
                        .make())
              ],
            ).p4(),
          ),
        ],
      ),
    ).py4();
  }
}
