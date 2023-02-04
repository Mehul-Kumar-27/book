import 'package:book/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  String type = "";
  String category = "";

  final _form = GlobalKey<FormState>();

  late DateTime _selectedDate;
  String dateText = "";
  late String time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black87),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_left_circle,
                        color: Colors.blue[300],
                        size: 28,
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        creatingGroup
                            ? const LinearProgressIndicator()
                            : Container(),
                        "Create"
                            .text
                            .textStyle(GoogleFonts.poppins(
                                fontSize: 30,
                                color: Colors.blue[500],
                                fontWeight: FontWeight.bold))
                            .make(),
                        const SizedBox(
                          height: 8,
                        ),
                        "New Group"
                            .text
                            .textStyle(GoogleFonts.poppins(
                                fontSize: 30,
                                color: Colors.blue[500],
                                fontWeight: FontWeight.bold))
                            .make(),
                        const SizedBox(
                          height: 25,
                        ),
                        label("Book Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        bookName(),
                        const SizedBox(
                          height: 30,
                        ),
                        label("Author Name"),
                        const SizedBox(
                          height: 12,
                        ),
                        authorName(),
                        const SizedBox(
                          height: 25,
                        ),
                        label("Description"),
                        const SizedBox(
                          height: 12,
                        ),
                        description(),
                        const SizedBox(
                          width: 25,
                        ),
                        label("Category"),
                        const SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          runSpacing: 10,
                          children: [
                            categorySelect("Horror", 0xff6d6e),
                            const SizedBox(
                              width: 20,
                            ),
                            categorySelect("Biopic", 0xff29732),
                            const SizedBox(
                              width: 20,
                            ),
                            categorySelect("Fantasy", 0xff6557ff),
                            const SizedBox(
                              width: 20,
                            ),
                            categorySelect("Fiction", 0xff234ebd),
                            const SizedBox(
                              width: 20,
                            ),
                            categorySelect("Poetry", 0xff2bc8d9),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        button(),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String groupId = DateTime.now().millisecondsSinceEpoch.toString();

  Future createGroupForUser() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(sharedPreferences!.getString("uid"))
        .collection("groups")
        .add({
      "category": category,
      "description": _description.text,
      "authorName": _authorController.text,
      "bookName": _bookNameController.text,
      "groupId": groupId,
      "admin": sharedPreferences!.getString("uid")
    });
  }

  Future createGroupForEveryOne() async {
    FirebaseFirestore.instance.collection("groups").add({
      "category": category,
      "description": _description.text,
      "authorName": _authorController.text,
      "bookName": _bookNameController.text,
      "groupId": groupId,
      "admin": sharedPreferences!.getString("uid")
    });
  }

  bool creatingGroup = false;

  Widget button() {
    return InkWell(
      onTap: () async {
        setState(() {
          creatingGroup = true;
        });
        if (_form.currentState!.validate()) {
          _form.currentState!.save();
          await createGroupForUser();
          await createGroupForEveryOne().then((value) {
            Navigator.pop(context);
          });
        }
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xff8a32f1), Color(0xffad32f9)]),
        ),
        child: const Center(
            child: Text(
          "Create",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _description,
        maxLines: null,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Description",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    ).py12();
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.green : Color(color),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget authorName() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _authorController,
        validator: (value) {
          if (value.toString().isEmpty) {
            return " Field cannot be empty";
          } else {
            return null;
          }
        },
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Author of book",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget bookName() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _bookNameController,
        validator: (value) {
          if (value.toString().isEmpty) {
            return " Field cannot be empty";
          } else {
            return null;
          }
        },
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Name Of book",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(label,
        style: const TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2,
        ));
  }
}
