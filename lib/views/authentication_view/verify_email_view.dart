import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';


import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../config/size_config.dart';
import '../../constants/colors.dart';
import '../alarmView.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final auth = FirebaseAuth.instance;
  late User user;

  late Timer timer;

  Future<void> checkEmailVerification() async {
    user = auth.currentUser!;

    await user.reload();

    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AlarmView()));
    }
  }

    @override
  void initState() {
    user = auth.currentUser!;
   

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(11.11)),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: screenWidth(1.39),
                top: screenHeight(42),
                right: screenWidth(1.39),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenWidth(34.71),
                  ),
                  Image(
                    height: screenHeight(170),
                    image: const AssetImage('assets/images/mail_box.png'),
                  ),
                  SizedBox(
                    height: screenWidth(34.71),
                  ),
  SlideAction(
outerColor: Color(0xFF2962FF),
              height: 60,
              // width:,
              sliderButtonIcon: Icon(
                FontAwesomeIcons.arrowRight,
                size: 20,
                color:Color(0xFF2962FF),
                
              ),
              text: "Swipe to get link",
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
                      onSubmit: () {
                        context.read<AuthBloc>().add(
                              const AuthEventSendEmailVerification(),
                            );
                      },
                  //     child: SizedBox(
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             "Send Verification Link",
                  //             style: GoogleFonts.poppins(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: screenWidth(11.8),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),

                  // ),
  ),
                  SizedBox(
                    height: screenHeight(27.8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        style: GoogleFonts.poppins(
                          color: AppColors.textColor1,
                          fontSize: screenWidth(10.42),
                          fontWeight: FontWeight.w500,
                        ),
                        'Already Verified?',
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEventLogOut(),
                              );
                        },
                        child: Text(
                          style: GoogleFonts.poppins(
                            color: AppColors.mainColor,
                            fontSize: screenWidth(10.42),
                            fontWeight: FontWeight.w500,
                          ),
                          'Login here!',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
