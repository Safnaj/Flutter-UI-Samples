import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/user_screen.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.arrow_back_ios)),
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).accentColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.done,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                            "Photo",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          )),
                      Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 50,
                                  child: ClipOval(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: pickedFile == null
                                          ? buildProfileIcon(context)
                                          : Image.memory(
                                              pickedFile!.readAsBytesSync(),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    final XFile? result = await ImagePicker()
                                        .pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 50);

                                    setState(() {
                                      pickedFile = File(result!.path);
                                    });
                                  },
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Akshaj Dev",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                            "Email Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 16),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "someemail@gmail.com",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  trailing: IconButton(
                      onPressed: () async {
                        try {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ChangeUserNameScreen()));
                        } on Exception {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(colors: [
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
                                  borderRadius: BorderRadius.circular(10)),
                              duration: Duration(
                                milliseconds: 500,
                              )));
                        }
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Theme.of(context).iconTheme.color,
                      )),
                  leading: SvgPicture.asset(
                    "assets/icons/rename.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text("Change Display Name"),
                  hoverColor: Colors.green,
                  subtitle: Text("Akshaj Dev"),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/reset_password.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text("Reset Password"),
                  trailing: IconButton(
                      color: Theme.of(context).iconTheme.color,
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (ctx) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/images/reset_password.png",
                                            height: 75,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Reset Password",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "You will receive a password reset email from us",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  try {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            elevation: 0,
                                                            content: Container(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(
                                                                            16),
                                                                        gradient: LinearGradient(
                                                                            colors: [
                                                                              Color(0xFF00bbff),
                                                                              Color(0xFF000ffea)
                                                                            ])),
                                                                child: Text(
                                                                  "Password Reset Email Sent",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15),
                                                                )),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10)),
                                                            duration: Duration(
                                                              milliseconds: 500,
                                                            )));
                                                  } on Exception {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            elevation: 0,
                                                            content: Container(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(
                                                                            16),
                                                                        gradient: LinearGradient(
                                                                            colors: [
                                                                              Color(0xFF00bbff),
                                                                              Color(0xFF000ffea)
                                                                            ])),
                                                                child: Text(
                                                                  "Rate Limit Reached Please Try Again Later",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15),
                                                                )),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10)),
                                                            duration: Duration(
                                                              milliseconds: 500,
                                                            )));
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.red)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildProfileIcon(BuildContext context) {
  final String? icon =
      "https://avatars.githubusercontent.com/u/62797898?s=400&v=4";
  return CachedNetworkImage(
    imageUrl: icon.toString(),
    fit: BoxFit.cover,
    errorWidget: (ctx, i, child) => Image.asset("assets/images/profile.png"),
    placeholder: (ctx, i) => Image.asset("assets/images/profile.png"),
  );
}
