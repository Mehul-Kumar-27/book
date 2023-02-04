// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:book/models/group.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class BookDetail extends StatefulWidget {
  GroupModel model;
  BookDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Material(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            elevation: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.network(
                  widget.model.bookUrl,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Book Name",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.bookName.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .make()
              .px16(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Author Name",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.authorName.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .make()
              .px16(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.description.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .overflow(TextOverflow.clip)
              .make()
              .px16(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.category.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .make()
              .px16(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
