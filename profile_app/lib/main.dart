import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'My profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var hiText = 'MyName';
    var aboutMe = 'About Me';
    var levelMe = 'small description here';
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // color: Colors.blueAccent,
        child: Scaffold(
          backgroundColor: Colors.blueAccent.shade200,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      'Hi, I\'m ${hiText}',
                      // style:GoogleFonts.oleoScript(color: Colors.deepPurple),
                      style: TextStyle(
                        fontFamily: 'Piedra',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  maxRadius: 90,
                  backgroundImage: AssetImage('assets/images/octocat.png'),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Center(
                    child: Text(
                      '$aboutMe-$levelMe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'contact me',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    //  mainAxisAlignment:MainAxisAlignment.center,
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      IconButton(
                        icon: Icon(Icons.phone_android, color: Colors.black),
                        iconSize: 40,
                        tooltip: 'tooltip-> number here',
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        iconSize: 40,
                        tooltip: 'tooltip-> your address here',
                        onPressed: null,
                      )
                    ],
                  ),
                )),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Change theme',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
