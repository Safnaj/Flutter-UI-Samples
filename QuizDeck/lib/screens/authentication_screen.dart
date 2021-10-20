import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/provider/preferencesProvider.dart';
import 'package:quizdeck/screens/home_screen.dart';

import 'package:quizdeck/widgets/animated_welcome.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({Key? key}) : super(key: key);
  static const routeName = "authentication-screen";

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool? _isSignUp;
  String? _image;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSignUp = (ModalRoute.of(context)!.settings.arguments ?? false) as bool?;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AuthenticationTitle(isSignUp: _isSignUp),
                    ),
                    if (!_isSignUp!)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedWelcome(),
                      ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: _isSignUp!
                                  ? InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () async {
                                        final imagePicker = ImagePicker();

                                        final XFile? result =
                                            await imagePicker.pickImage(
                                                imageQuality: 50,
                                                source: ImageSource.gallery);
                                        setState(() {
                                          _image = result?.path;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          child: _image == null
                                              ? Image.asset(
                                                  "assets/images/profile.png")
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.file(
                                                    File(_image!),
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),

                            AuthenticationTextField(
                              validator: (value) {
                                if (value!.contains("@")) {
                                  return null;
                                }
                                return "Enter a valid email";
                              },
                              isEnd: false,
                              hintText: "Email",
                              textEditingController: _emailController,
                            ),
                            AuthenticationTextField(
                              validator: (value) {
                                if (value!.length >= 8) {
                                  return null;
                                } else {
                                  return "Minimum of 8 character is required";
                                }
                              },
                              isEnd: true,
                              hintText: "Password",
                              obscureText: true,
                              textEditingController: _password,
                            ),

                            // authentication button
                            Material(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (_isSignUp!) {
                                      try {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                HomeScreen.routeName);
                                      } catch (error) {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/icons/error.svg"),
                                                          Text(
                                                            "Some error occured",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Something Went Wrong",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                            child: Text(
                                                              "Ok",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            style: ButtonStyle(
                                                                shape: MaterialStateProperty.all<
                                                                        OutlinedBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10))),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .red)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                      }
                                    } else {
                                      try {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                HomeScreen.routeName);
                                      } catch (error) {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/icons/error.svg"),
                                                          Text(
                                                            "Some error occured",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Something Went Wrong",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                            child: Text(
                                                              "Ok",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            style: ButtonStyle(
                                                                shape: MaterialStateProperty.all<
                                                                        OutlinedBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10))),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .red)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: _isSignUp!
                                      ? Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    if (!_isSignUp!)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (_emailController.text.isNotEmpty) {
                                try {
                                  await context
                                      .read<PreferencesProvider>()
                                      .updateAuthRate();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          content: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF00bbff),
                                                        Color(0xFF000ffea)
                                                      ])),
                                              child: Text(
                                                "Password Reset Email Sent",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              )),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          duration: Duration(
                                            milliseconds: 500,
                                          )));
                                } on Exception {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          content: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF00bbff),
                                                        Color(0xFF000ffea)
                                                      ])),
                                              child: Text(
                                                "Rate Limit Reached Please Try Again Later",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              )),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          duration: Duration(
                                            milliseconds: 500,
                                          )));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        content: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF00bbff),
                                                      Color(0xFF000ffea)
                                                    ])),
                                            child: Text(
                                              "Please Provide an Email Address",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            )),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        duration: Duration(
                                          milliseconds: 500,
                                        )));
                              }
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 50,
                      width: 175,
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ))),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/google.png",
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Sign In with google",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      },
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${_isSignUp! ? 'Already Have an Account?' : 'Don\'t Have An Account ?'}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                AuthenticationScreen.routeName,
                                arguments: !_isSignUp!);
                          },
                          child: _isSignUp!
                              ? Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              : Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AuthenticationTitle extends StatelessWidget {
  const AuthenticationTitle({
    Key? key,
    required bool? isSignUp,
  })  : _isSignUp = isSignUp,
        super(key: key);

  final bool? _isSignUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: _isSignUp!
          ? Text(
              "Create an account",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )
          : Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
    );
  }
}

class AuthenticationTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isEnd;
  final bool obscureText;
  final String? Function(String?) validator;

  const AuthenticationTextField({
    required this.isEnd,
    required this.validator,
    this.obscureText = false,
    required this.hintText,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        autofillHints: [AutofillHints.email],
        validator: validator,
        autocorrect: true,
        obscureText: obscureText,
        controller: textEditingController,
        style: TextStyle(fontWeight: FontWeight.w600),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 2)),
          hintStyle: Theme.of(context).textTheme.bodyText1,
          labelText: hintText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
