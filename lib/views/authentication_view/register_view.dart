import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/neon.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../auth/auth_exception.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../config/size_config.dart';
import '../../constants/colors.dart';
import '../../dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(
              context,
              "Weak Password",
            );
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              "Email Already In use",
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              "Invalid Email",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Failed To register !",
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.only(top: screenHeight(30)),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: screenWidth(13.2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(42),
                    ),
                    // Text(
                    //   "Register",
                    //   style: GoogleFonts.poppins(
                    //     fontSize: screenWidth(22.24),
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.mainColor,
                    //   ),
                    // ),

                    Neon(
                      text: "Register",
                      color: Colors.blue,
                      fontSize: 40,
                      font: NeonFont.Beon,
                      flickeringText: true,
                      flickeringLetters: null,
                      glowingDuration: new Duration(seconds: 5),
                    ),
                    SizedBox(
                      height: screenHeight(40),
                    ),
                    Neon(
                      text: "Let's setup your account",
                      color: Colors.blue,
                      fontSize: 20,
                      font: NeonFont.Beon,
                      flickeringText: true,
                      flickeringLetters: null,
                      glowingDuration: new Duration(seconds: 10),
                    ),
                    SizedBox(
                      height: screenHeight(14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight(14),
                        right: screenWidth(13.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Username",
                          //   style: GoogleFonts.poppins(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: screenWidth(11.8),
                          //     color: AppColors.textColor,
                          //   ),
                          // ),
                          //                Neon(
                          //   text: "Username",
                          //   color: Colors.blue,
                          //   fontSize: 30,
                          //   font: NeonFont.Beon,
                          //   flickeringText: true,
                          //   flickeringLetters: null,
                          //   glowingDuration: new Duration(seconds: 5),
                          // ),
                          SizedBox(
                            height: screenHeight(10.41),
                          ),
                          SizedBox(
                            height: screenHeight(50),
                            child: TextField(
                               style: TextStyle(color:Colors.white),
                              controller: _username,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                hintText: 'Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(screenHeight(6.94)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(27.8),
                          ),
                          // Text(
                          //   "Email Address",
                          //   style: GoogleFonts.poppins(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: screenWidth(11.8),
                          //     color: AppColors.textColor,
                          //   ),
                          // ),
                          SizedBox(
                            height: screenHeight(10.41),
                          ),
                          SizedBox(
                            height: screenHeight(50),
                            child: TextField(
                               style: TextStyle(color:Colors.white),
                              controller: _email,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(screenHeight(6.94)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(27.8),
                          ),
                          // Text(
                          //   "Password",
                          //   style: GoogleFonts.poppins(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: screenWidth(11.8),
                          //     color: Colors.black,
                          //   ),
                          // ),
                          SizedBox(
                            height: screenHeight(10.41),
                          ),
                          SizedBox(
                            height: screenHeight(50),
                            child: TextField(
                               style: TextStyle(color:Colors.white),
                              controller: _password,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(screenHeight(6.94)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(42),
                          ),
                          SlideAction(
                            outerColor: Color(0xFF2962FF),
                            height: 60,
                            // width:,
                            sliderButtonIcon: Icon(
                              FontAwesomeIcons.arrowRight,
                              size: 20,
                              color: Color(0xFF2962FF),
                            ),
                            text: "REGISTER",
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            onSubmit: () async {
                              final email = _email.text;
                              final password = _password.text;
                              final username = _username.text;
                              context.read<AuthBloc>().add(
                                    AuthEventRegister(
                                      email,
                                      password,
                                      username,
                                    ),
                                  );
                            },
                            //     child: SizedBox(
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           SizedBox(
                            //             width: screenWidth(9.86),
                            //           ),
                            //           Text(
                            //             "Register",
                            //             style: GoogleFonts.poppins(
                            //               color: Colors.white,
                            //               fontSize: screenWidth(12.51),
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ),
                            //           const Icon(
                            //             Icons.arrow_forward,
                            //             color: Colors.white,
                            //           ),

                            //         ],
                            //       ),
                            //     ),
                            //   ),

                            // ),
                          ),
                          SizedBox(
                            height: screenHeight(27.76),
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
                                'Already Registered?',
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
