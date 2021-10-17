import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DeckIconWidget extends StatelessWidget {
  final List<String>? icons;
  const DeckIconWidget({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.1,
                height: 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                "Choose Icon",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: icons!.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        elevation: 1,
                        child: InkWell(
                          splashColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.of(context).pop(icons![i]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CachedNetworkImage(imageUrl: icons![i]),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
