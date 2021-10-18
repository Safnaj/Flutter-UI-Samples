import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'slide_tile.dart';
import 'core.dart';


class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  int slideIndex = 0;
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).primaryColor,Colors.blue[500]],
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter,
                stops:[0.4,0.8],
              )
          ),
          padding: const  EdgeInsets.only(left: 32,),
          child: Swiper(
            itemCount: intro_image.length,
            itemWidth: MediaQuery.of(context).size.width -100,
            layout: SwiperLayout.STACK,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeSize: 10,
                space: 8,
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
            itemBuilder: (context,index){
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 100.0,),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(

                            children: [
                              SizedBox(height: intro_image[index].height,),
                              Image.asset(intro_image[index].imagePath),
                              Text(
                                intro_image[index].title,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 40,
                                  color: const Color(0xff47455f),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                intro_image[index].desc,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 20,
                                  color: const Color(0xff47455f),
                                  //fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 32,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: getStartedButton(),
      ),
    );
  }

  //Not required now,I am leaving this in case somebody needs to use this
/*
  Widget sliderBottomBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          skipButton(),
          sliderIndicator(),
          nextButton(),
        ],
      ),
    );
  }

  FlatButton skipButton() {
    return FlatButton(
      splashColor: Colors.pink[500],
      child: Text(
        "SKIP",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
        controller.animateToPage(
          2,
          duration: Duration(milliseconds: 400),
          curve: Curves.linear,
        );
      },
    );
  }

  Widget sliderIndicator() {
    return Container(
      child: Row(
        children: [
          for (int i = 0; i < 3; i++)
            i == slideIndex ? pageIndicatorDot(true) : pageIndicatorDot(false),
        ],
      ),
    );
  }

  FlatButton nextButton() {
    return FlatButton(
      splashColor: Colors.pink[500],
      child: Text(
        "NEXT",
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        controller.animateToPage(slideIndex + 1,
            duration: Duration(milliseconds: 500), curve: Curves.linear);
      },
    );
  }

  Widget pageIndicatorDot(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }*/

  Widget getStartedButton() {
    return InkWell(
      child: Container(
        height: 60,
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        child: Text(
          "GET STARTED NOW",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CoreScreen()));
      },
    );
  }
}
