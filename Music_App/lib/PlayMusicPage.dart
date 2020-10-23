import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class PlayMusicPage extends StatefulWidget {
  @override
  _PlayMusicPageState createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent.shade100,
      appBar: AppBar(
        // leading: new Icon(Icons.arrow_back_rounded,color: Colors.yellow.shade500
        iconTheme: new IconThemeData(color: Colors.yellow.shade500),
        backgroundColor: Colors.purple.shade400,
        actions: [
          IconButton(
            padding: EdgeInsets.all(10),
            icon: Icon(
              Icons.settings,
              color: Colors.yellow.shade500,
              size: 30,
            ),
            onPressed: null,
          )
        ],
        title: Text(
          'Song Title',
          style: TextStyle(color: Colors.yellow.shade500),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        // color: Colors.blueAccent,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.black87,
                Colors.deepPurple,
                Colors.purple.shade400,
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.purple.shade700,
                  maxRadius: 170,
                  backgroundImage: AssetImage("Assets/images/music.jpg"),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Center(
                      child: BorderedText(
                    strokeColor: Colors.deepPurple.shade900,
                    child: Text(
                      'Song Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade100,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: BorderedText(
                    strokeColor: Colors.white,
                    child: Text(
                      'Artist',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.purple.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.linear_scale_outlined),
                  ),
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      IconButton(
                        icon: Icon(Icons.skip_previous, color: Colors.black),
                        iconSize: 50,
                        tooltip: 'tooltip-> go to previous song',
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.undo_outlined, color: Colors.black),
                        iconSize: 50,
                        tooltip: 'tooltip-> ',
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.play_circle_fill_outlined,
                            color: Colors.black),
                        iconSize: 50,
                        tooltip: 'tooltip-> play song',
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.redo_outlined, color: Colors.black),
                        iconSize: 50,
                        tooltip: 'tooltip-> ',
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.black,
                        ),
                        iconSize: 50,
                        tooltip: 'tooltip-> go to next song',
                        onPressed: null,
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
