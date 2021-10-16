import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          width: width*0.4,
          height: height*0.3,
          decoration: BoxDecoration(
              border:Border.all(color: Theme.of(context).primaryColor),
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/avatar.png')
              )
          ),
        ),
        Stack(
          children: [
            Container(
              height: height*0.07,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(

              child: Row(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(width*0.25, 0, 0, 0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, height*0.01, 0, 0)),
                      Text('Chris Rogers',style: TextStyle(fontSize: 15,color: Colors.white),),
                      Text('chris.rogers@gmail.com',style: TextStyle(fontSize: 15,color: Colors.white),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
    /*Card(
      elevation: Constants.CARD_ELEVATION,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment(1.0, -0.9),
              heightFactor: 0.1,
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 40,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Benjamin Rogers',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 6),
              child: Text(
                'ben.rogers@gmail.com',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
