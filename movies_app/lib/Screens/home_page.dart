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
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchEditingController = TextEditingController();
  double mediaWidth = 0;
  double mediaHeight = 0;

  List<Widget> getImageSliders(context) {
    List<Widget> imageSliders = imgList
        .map((item) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoviePage()),
                ).then((value) => setState(() {}));
              },
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: const Icon(Icons.favorite_border, color: Colors.black45)),
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
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
    mediaWidth = MediaQuery.of(context).size.width;
    mediaHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(mediaWidth * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi User,\nBook your movie ticket",
                      style: TextStyle(color: Colors.black, fontSize: mediaWidth * 0.065),
                    ),
                    CircleAvatar(
                      child: const Icon(Icons.person, color: Colors.white),
                      //                    Image.asset(
                      //                      "assets/images/avatar.png",
                      //                    ),
                      radius: mediaWidth * 0.07,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: TextField(
                      controller: searchEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: InkWell(
                            onTap: () {
                              //                      initiateSearch();
                            },
                            child: const Icon(
                              Icons.tune,
                              color: Colors.black,
                            )),
                        hintText: "Search for movies",
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    )),
                SizedBox(
                  height: mediaHeight * 0.025,
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
                                borderRadius: BorderRadius.circular(10), // Creates border
                                color: Colors.black),
                            tabs: const [
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
                          height: mediaHeight * 0.025,
                        ),
                        Container(
                          height: mediaHeight * 0.5,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: mediaWidth * 0.9,
                                  height: mediaHeight * 0.75,
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
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "All Movies",
                                          style: TextStyle(color: Colors.black, fontSize: 20),
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
                              ),
                              Container(),
                              Container(),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
