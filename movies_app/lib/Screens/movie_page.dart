import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/actor1.png',
  'assets/images/actor2.jpeg',
  'assets/images/actor3.jpg',
  'assets/images/actor4.jpeg',
  'assets/images/actor5.jpeg',
];

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final List<Widget> cast = imgList
      .map((item) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                Text("Actor Name")
              ],
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Image.asset(
              'assets/images/freeguy.jpeg',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 100, 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Free Guy', style: TextStyle(fontSize: 20)),
                            Text('Comedy',
                                style: TextStyle(
                                    fontSize: 15,
                                    height: 1.5,
                                    color: Colors.black45)),
                            Text('1hr 55min',
                                style: TextStyle(
                                    fontSize: 15,
                                    height: 1.5,
                                    color: Colors.black45)),
                            Text(
                              '7.3/10',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                      "A bank teller discovers that he's actually an NPC inside a brutal, open world video game.",
                      style: TextStyle(color: Colors.black45)),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Cast', style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cast,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Text(
                        "Book Tickets",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 150.0,
          left: 20.0,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.asset(
                'assets/images/poster5.jpeg',
                height: 250,
              )),
        )
      ]),
    );
  }
}
