import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/flash_card_model.dart';
import 'package:quizdeck/provider/flash_card_provider.dart';
import 'package:quizdeck/screens/add_flash_card.dart';

class FlashCardList extends StatelessWidget {
  final List<FlashCardModel> flashCards;
  const FlashCardList({Key? key, required this.flashCards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        height: 113.0 * flashCards.length,
        child: ImplicitlyAnimatedList<FlashCardModel>(
          physics: NeverScrollableScrollPhysics(),
          areItemsTheSame: (a, b) => a.id == b.id,
          items: flashCards,
          itemBuilder: (ctx, animation, item, index) {
            return SizeFadeTransition(
              animation: animation,
              curve: Curves.easeInOut,
              child: FlashCardWidget(
                e: item,
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlashCardWidget extends StatelessWidget {
  final FlashCardModel e;
  const FlashCardWidget({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
      ),
      child: Slidable(
        actionPane: SlidableStrechActionPane(),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: IconSlideAction(
              color: Colors.greenAccent,
              iconWidget: Icon(
                Icons.edit,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AddFlashCardScreen.routeName,
                    arguments: {"isUpdate": true, "data": e});
              },
            ),
          ),
        ],
        secondaryActions: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: IconSlideAction(
              color: Colors.orangeAccent,
              iconWidget: Icon(
                Icons.delete,
              ),
              onTap: () {
                context.read<FlashCardProvider>().removeFlashCard(flashCard: e);
              },
            ),
          ),
        ],
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${e.frontSide}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${e.backSide}",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
