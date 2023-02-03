import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:velocity_x/velocity_x.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/bloc/auth_event.dart';
import '../global/global.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: "Welcome ${sharedPreferences!.getString("name")}"
            .text
            .textStyle(GoogleFonts.pacifico(fontSize: 25))
            .color(Colors.grey[800])
            .overflow(TextOverflow.ellipsis)
            .make(),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Container(
            //decoration: BoxDecoration(color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    icon: const Icon(Icons.login))
              ],
            ).px20(),
          )
        ],
      ),
    );
  }
}
