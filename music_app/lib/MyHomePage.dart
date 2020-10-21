import 'package:flutter/material.dart';
import 'package:music_app/PlayMusicPage.dart';
import 'package:bordered_text/bordered_text.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        actions: [
          IconButton(
            padding: EdgeInsets.all(10),
            icon: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayMusicPage()),
              );
            },
          )
        ],
        title: Text(widget.title),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.black,
                Colors.blue.shade700,
                Colors.purple.shade700,
              ])),
          child: ListView(
            padding: EdgeInsets.all(5),
            children: <Widget>[
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.purple.shade900,
                semanticContainer: true,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  hoverColor: Colors.red.shade100,
                  selectedTileColor: Colors.red.shade900,
                  leading: Icon(
                    Icons.music_note_outlined,
                    size: 40,
                    color: Colors.yellow.shade500,
                  ),
                  title: Text('Song Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Subtitle',
                      style: TextStyle(
                          color: Colors.purpleAccent.shade100, fontSize: 15)),
                  trailing: Icon(Icons.play_circle_fill,
                      color: Colors.yellow.shade600, size: 40),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: null,
        tooltip: 'Shuffle All',
        child: Icon(Icons.shuffle),
      ),
      drawer: Drawer(
        child: Container(
          // color: Colors.purple.shade700,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.black,
                Colors.blue.shade700,
                Colors.purple.shade700,
              ])),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.purple.shade900,
                      image: DecorationImage(
                          image: AssetImage("Assets/images/music.jpg"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 1, top: 50, right: 1, bottom: .5),
                    child: BorderedText(
                      strokeColor: Colors.white,
                      child: Text(
                        'MY MUSIC APP',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )),
              ListTile(
                leading: Icon(Icons.collections_outlined, color: Colors.white),
                title: Text(
                  'My Music Gallery',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.replay_rounded, color: Colors.white),
                title: Text('Recents',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.favorite_outline, color: Colors.white),
                title: Text('Favourites',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.queue_music, color: Colors.white),
                title: Text('Play Lists',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.note_add, color: Colors.white),
                title: Text('Lyrics Store',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.rss_feed_outlined, color: Colors.white),
                title: Text('PodCasts',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined, color: Colors.white),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
