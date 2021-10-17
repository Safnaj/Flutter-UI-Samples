import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';
import 'package:quizdeck/provider/preferencesProvider.dart';
import 'package:quizdeck/screens/authentication_screen.dart';
import '../screens/account_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "settings-screen";
  final Uri emailLaunchUri = Uri(
    scheme: "mailTo",
    path: 'akshajdevkv@gmail.com',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Account",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: buildProfileIcon(context)),
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Akshaj Dev",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                          Text(
                            "Personal Info",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => AccountScreen())),
                          icon: Icon(Icons.keyboard_arrow_right_outlined)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Preferences",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      DarkModeTile(
                        isDark: context.read<PreferencesProvider>().isDark,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/rate.svg",
                          color: Theme.of(context).iconTheme.color,
                          height: 25,
                        ),
                        title: Text("Rate Us"),
                        onTap: () => LaunchReview.launch(),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/contact.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text("Contact Us"),
                        onTap: () {
                          print(emailLaunchUri.toString());
                          launch(emailLaunchUri.toString());
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/info.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text("About"),
                        onTap: () => LaunchReview.launch(),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/version.svg",
                          color: Theme.of(context).iconTheme.color,
                          height: 25,
                        ),
                        title: Text("Version"),
                        subtitle: Text("1.0.0"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.privacy_tip,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text("Privacy Policy"),
                        onTap: () {
                          launch(Uri(
                                  scheme: "https",
                                  path:
                                      "docs.google.com/document/d/1tUK0VcioEsqlChXal5LWDJ1Te7fYpiU_rPZ24f2VLFg")
                              .toString());
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.library_books,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text("Terms and Conditions"),
                        onTap: () {
                          launch(Uri(
                                  scheme: "https",
                                  path:
                                      "docs.google.com/document/d/1cM-V-MDXLsH8tlxTP_woZ91PcclquH6IjjFCmqVpChI")
                              .toString());
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text("Log out"),
                        onTap: () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AuthenticationScreen.routeName, (route) {
                            return false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DarkModeTile extends StatefulWidget {
  final bool isDark;
  DarkModeTile({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  _DarkModeTileState createState() => _DarkModeTileState();
}

class _DarkModeTileState extends State<DarkModeTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        "assets/icons/dark_mode.svg",
        color: Theme.of(context).iconTheme.color,
        height: 25,
      ),
      title: Text("Dark Mode"),
      trailing: Switch(
        value: widget.isDark,
        onChanged: (value) async {
          await context.read<PreferencesProvider>().toggleDarkMode(value);
        },
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
