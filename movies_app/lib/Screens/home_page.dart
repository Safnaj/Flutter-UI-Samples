import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moviesapp/Screens/movie_page.dart';

final List<String> imgList = [
  'assets/images/poster1.jpeg',
  'assets/images/poster2.jpeg',
  'assets/images/poster3.jpeg',
  'assets/images/poster4.jpeg',
  'assets/images/poster5.jpeg',
  'assets/images/poster6.jpeg',
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchEditingController = TextEditingController();

  List<Widget> getImageSliders(context) {
    List<Widget> imageSliders = imgList
        .map((item) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoviePage()),
                ).then((value) => setState(() {}));
              },
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child:
                            Icon(Icons.favorite_border, color: Colors.black45)),
                  ),
                ],
              ),
            ))
        .toList();
    return imageSliders;
  }

  final List<Widget> allMovies = imgList
      .map((item) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.asset(
                item,
                fit: BoxFit.fitWidth,
                width: 150,
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hi User,\nBook your movie ticket",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  CircleAvatar(
                    child: Icon(Icons.person, color: Colors.white),
//                    Image.asset(
//                      "assets/images/avatar.png",
//                    ),
                    radius: 30,
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for movies",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
//                      initiateSearch();
                          },
                          child: Icon(
                            Icons.tune,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  )),
              SizedBox(
                height: 20,
              ),
              DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TabBar(
                          unselectedLabelColor: Colors.black45,
                          overlayColor: null,
                          enableFeedback: false,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // Creates border
                              color: Colors.black),
                          tabs: [
                            Tab(
                              text: "New",
                            ),
                            Tab(
                              text: "Popular",
                            ),
                            Tab(
                              text: "Showing Now",
                            ),
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.58,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TabBarView(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      aspectRatio: 1,
                                      enlargeCenterPage: true,
                                    ),
                                    items: getImageSliders(context),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "All Movies",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: allMovies,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
    ;
  }
}
