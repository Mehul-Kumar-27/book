// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:book/views/book_details.dart';
import 'package:book/views/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/neon.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:book/models/group.dart';
import 'package:book/views/create_group.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/bloc/auth_event.dart';
import '../global/global.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  // String imageString;
  Stream? feeds;
  

  Future<Stream<QuerySnapshot>> getGroup() async {
    return FirebaseFirestore.instance.collection("groups").snapshots();
  }

  getAllGroups() {
    getGroup().then((value) {
      setState(() {
        feeds = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllGroups();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Neon(
            text: "Let's Connect",
            color: Colors.blue,
            fontSize: 30,
            font: NeonFont.Monoton,
            flickeringText: false,
            flickeringLetters: null,
            glowingDuration: new Duration(seconds: 5),
          ),
          backgroundColor: Color(0xFF2962FF),
        ),
        drawer: Drawer(
            backgroundColor: Color(0xFF2962FF),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      // SizedBox(height: 10),
                      // Container(
                      //   decoration: new BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.white,
                      //     // image: new DecorationImage(
                      //         // fit: BoxFit.fill,
                      //         // image:
                      //             // imageString != null && imageString.isNotEmpty
                      //             //     ? Image.memory(base64Decode(imageString))
                      //             //         .image
                      //             //     : ExactAssetImage('', scale: 1.0)),
                      //   ),
                      // ),
            
                      Center(
                    

                        child: CircleAvatar(

                          radius: 30,
                          // backgroundImage: AssetImage('assets/img.jpg'),
                       ),
                      ),
                      SizedBox(height: 10),
                      Text("Flutter Developer",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text("dev@abc.com",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ),
                const Divider(
                    thickness: .06, color: Color.fromARGB(255, 30, 29, 29)),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.person),
                  title: const Text('My Profile',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Add Navigation logic here
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.book),
                  title: const Text('My Books',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Add Navigation logic here
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.subscriptions),
                  title: const Text('Go Premium',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Add Navigation logic here
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Add Navigation logic here
                      context
                                .read<AuthBloc>()
                                .add(const AuthEventLogOut());

                  },
                ),
              ],
            )),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(onPressed: () {}, icon: const Icon(Icons.person),color: Colors.white,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // IconButton(
                      //   onPressed: () {

                      //     Navigator.pushAndRemoveUntil(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>),
                      //         (route) => false);
                      //   },
                      //   icon: const Icon(Icons.person),
                      //   color: Colors.white,
                      // ),
                      // IconButton(
                      //     onPressed: () {
                      //       context
                      //           .read<AuthBloc>()
                      //           .add(const AuthEventLogOut());
                      //     },
                      //     icon: const Icon(Icons.login),color: Colors.white,),
                    ],
                  )
                ],
              ).px20(),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //     Neon(
                //       text: "Let's Connect",
                //       color: Colors.blue,
                //       fontSize: 35,
                //       font: NeonFont.Automania,
                //       flickeringText: false,
                //       flickeringLetters: null,
                //       glowingDuration: new Duration(seconds: 1),
                //     ),
                SizedBox(
                  height: 20,
                ),
                Neon(
                  text: "join the community of your intersts !",
                  color: Colors.blue,
                  fontSize: 20,
                  font: NeonFont.TextMeOne,
                  flickeringText: true,
                  flickeringLetters: null,
                  glowingDuration: new Duration(seconds: 2),
                ),
                // const Divider(
                // thickness: 2,
                // color: Color(0xFF2962FF),
                // )
              ],
            ).px8(),
            Expanded(
                child: StreamBuilder(
              stream: feeds,
              builder: (context, AsyncSnapshot snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          GroupModel model = GroupModel.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return GestureDetector(
                            onTap: () {},
                            child: GroupDesign(
                              model: model,
                              index: index,
                            ),
                          );
                        });
              },
            )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          // focusColor: Color(0xFF2962FF),
          backgroundColor: Color(0xFF2962FF),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateGroup()));
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFF2962FF),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.work_outline_outlined,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.widgets_outlined,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupDesign extends StatefulWidget {
  GroupModel model;
  int index;
  GroupDesign({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  State<GroupDesign> createState() => _GroupDesignState();
}

class _GroupDesignState extends State<GroupDesign> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetail(model: widget.model)));
      },
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.model.bookUrl,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Name: ${widget.model.bookName}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                        fontSize: 17,
                      ))
                      .make(),
                  "Author: ${widget.model.authorName}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                        fontSize: 17,
                      ))
                      .make(),
                  "Category: ${widget.model.category}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                        fontSize: 17,
                      ))
                      .make(),
                ],
              )
            ],
          ),
        ).p8(),
      ).py12(),
    );
  }
}
