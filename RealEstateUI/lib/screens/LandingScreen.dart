import 'package:flutter/material.dart';
import 'DetailPage.dart';
import '../custom/BorderIcon.dart';
import '../custom/OptionButton.dart';
import '../sample_data.dart';
import '../utils/constants.dart';
import '../utils/custom_functions.dart';
import '../utils/widget_functions.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Since there are places where we have to use common padding, we are setting it as variable
    final double padding = 25;
    final EdgeInsets sidePadding = EdgeInsets.symmetric(horizontal: padding);

    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BorderIcon(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.menu,
                          color: COLOR_BLACK,
                        ),
                      ),
                      BorderIcon(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.settings,
                          color: COLOR_BLACK,
                        ),
                      )
                    ],
                  ),
                ),
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Text(
                    "City",
                    style: themeData.textTheme.bodyText2,
                  ),
                ),
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Text(
                    "San Francisco",
                    style: themeData.textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: sidePadding,
                  child: Divider(
                    height: padding,
                    color: COLOR_GREY,
                  ),
                ),
                addVerticalSpace(10),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      "<\$220,000",
                      "For Sale",
                      "3-4 Beds",
                      ">1000 sqft"
                    ]
                        .map((filterItem) => ChoiceOption(text: filterItem))
                        .toList(),
                  ),
                ),
                addVerticalSpace(10),
                Expanded(
                  child: Padding(
                    padding: sidePadding,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: RE_DATA.length,
                      itemBuilder: (context, index) {
                        return RealEstateItem(itemData: RE_DATA[index]);
                      },
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 20,
              width: size.width,
              child: Center(
                child: OptionButton(
                  text: "Map View",
                  icon: Icons.map_rounded,
                  width: size.width * 0.4,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(left: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: COLOR_GREY.withAlpha(25),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 13,
      ),
      child: Text(
        text,
        style: themeData.textTheme.headline5,
      ),
    );
  }
}

class RealEstateItem extends StatelessWidget {
  final dynamic itemData;

  const RealEstateItem({Key? key, required this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        itemData: itemData,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(itemData["image"]),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: BorderIcon(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.favorite_border, color: COLOR_BLACK),
                ),
              )
            ],
          ),
          addVerticalSpace(15),
          Row(
            children: [
              Text(
                "${formatCurrency(itemData["amount"])}",
                style: themeData.textTheme.headline1,
              ),
              addHorizontalSpace(10),
              Text(
                "${itemData["address"]}",
                style: themeData.textTheme.bodyText2,
              )
            ],
          ),
          addVerticalSpace(10),
          Text(
            "${itemData["bedrooms"]} bedrooms / ${itemData["bathrooms"]} bathrooms / ${itemData["area"]} sqft",
            style: themeData.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
