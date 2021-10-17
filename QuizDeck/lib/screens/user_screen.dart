import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/provider/preferencesProvider.dart';

class ChangeUserNameScreen extends StatefulWidget {
  ChangeUserNameScreen({Key? key}) : super(key: key);

  @override
  _ChangeUserNameScreenState createState() => _ChangeUserNameScreenState();
}

class _ChangeUserNameScreenState extends State<ChangeUserNameScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Display Name"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                if (_textEditingController.text.isEmpty) {
                  setState(() {
                    _errorText = "Please Enter A Display Name";
                  });
                } else {
                  try {
                    await context.read<PreferencesProvider>().updateAuthRate();
                  } on Exception {
                    await showDialog(
                        context: context,
                        builder: (ctx) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/error.svg",
                                        height: 75,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Rate Limit Reached",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "You have exceeded your rate limit, please try again after a few mintues",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OutlinedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  }

                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                onChanged: (text) {
                  if (_errorText != null) {
                    print("setStates");
                    setState(() {
                      _errorText = null;
                    });
                  }
                },
                controller: _textEditingController,
                style: TextStyle(
                    fontFamily: "roboto", fontWeight: FontWeight.w500),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  counterStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  hintText: "New Display Name",
                  errorText: _errorText,
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                  labelText: "New Display Name",
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
                maxLength: 20,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
