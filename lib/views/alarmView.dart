// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: Column(
          children: [
            Container(
              //decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventLogOut());
                          },
                          icon: const Icon(Icons.login)),
                    ],
                  )
                ],
              ).px20(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Let's Connect"
                    .text
                    .textStyle(GoogleFonts.openSans(
                        fontSize: 25,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold))
                    .make(),
                const SizedBox(
                  height: 10,
                ),
                "Join the community of your intersts !"
                    .text
                    .textStyle(GoogleFonts.openSans(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600))
                    .make(),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.indigo,
                )
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateGroup()));
        }),
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
      onTap: (){
        
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
