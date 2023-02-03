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
    return Container(
      child: Center(
        child: widget.model.groupId.text.make(),
      ),
    );
  }
}
