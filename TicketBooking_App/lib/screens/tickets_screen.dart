import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:ticketbook/screens/ticket_view.dart';
import 'package:ticketbook/utils/app_info_list.dart';
import 'package:ticketbook/utils/app_layout.dart';
import 'package:ticketbook/utils/app_styles.dart';
import 'package:gap/gap.dart';
import 'package:ticketbook/utils/ticket_tabs.dart';
import 'package:ticketbook/widgets/column_layout.dart';
import 'package:ticketbook/widgets/layout_widget_builder.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(children: [
        ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getHeight(20),
            vertical: AppLayout.getHeight(20),
          ),
          children: [
            Gap(AppLayout.getHeight(40)),
            Text("Tickets", style: Styles.headLineStyle1),
            Gap(AppLayout.getHeight(20)),
            const AppTicketTabs(firstTab: "Upcoming", secondTab: "Previous"),
            Gap(AppLayout.getHeight(20)),
            Container(
              padding: EdgeInsets.only(
                left: AppLayout.getHeight(15),
              ),
              child: TicketView(
                ticket: ticketList[0],
                isColor: true,
              ),
            ),
            SizedBox(height: AppLayout.getHeight(1)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppLayout.getHeight(15),
                vertical: AppLayout.getHeight(20),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(15),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AppColumnLayout(
                        firstText: "Flutter DB",
                        secondText: "Passenger",
                        alignment: CrossAxisAlignment.start,
                      ),
                      AppColumnLayout(
                        firstText: "0812 98124",
                        secondText: "Passport",
                        alignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(20)),
                  const AppLayoutBuilderWidget(
                    sections: 15,
                    isColor: false,
                    width: 5,
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AppColumnLayout(
                        firstText: "45678 1456789023",
                        secondText: "Number of E-Ticket",
                        alignment: CrossAxisAlignment.start,
                      ),
                      AppColumnLayout(
                        firstText: "B2S45698 ",
                        secondText: "Booking code",
                        alignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(20)),
                  const AppLayoutBuilderWidget(
                    sections: 15,
                    isColor: false,
                    width: 5,
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/visa.png", scale: 11),
                              Text(" *** 2462", style: Styles.headLineStyle3),
                            ],
                          ),
                          Gap(AppLayout.getHeight(5)),
                          Text("Payment method", style: Styles.headLineStyle4),
                        ],
                      ),
                      const AppColumnLayout(
                        firstText: "\$220.69",
                        secondText: "Price",
                        alignment: CrossAxisAlignment.end,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: AppLayout.getHeight(1)),
            //bar code
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(AppLayout.getHeight(21)),
                    bottomLeft: Radius.circular(AppLayout.getHeight(21))),
              ),
              margin: EdgeInsets.only(
                  left: AppLayout.getWidth(15), right: AppLayout.getWidth(15)),
              padding: EdgeInsets.only(
                  top: AppLayout.getHeight(25),
                  bottom: AppLayout.getHeight(20)),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: AppLayout.getHeight(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppLayout.getHeight(15)),
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: 'https://github.com/martinovovo',
                    drawText: false,
                    color: Styles.textColor,
                    width: double.infinity,
                    height: 70,
                  ),
                ),
              ),
            ),
            Gap(AppLayout.getHeight(20)),
            Container(
              padding: EdgeInsets.only(
                left: AppLayout.getHeight(15),
              ),
              child: TicketView(
                ticket: ticketList[0],
              ),
            ),
          ],
        ),
        Positioned(
          left: AppLayout.getWidth(25),
          top: AppLayout.getHeight(243),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Styles.textColor, width: 2),
            ),
            child: CircleAvatar(
              maxRadius: 4,
              backgroundColor: Styles.textColor,
            ),
          ),
        ),
        Positioned(
          right: AppLayout.getWidth(25),
          top: AppLayout.getHeight(243),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Styles.textColor, width: 2),
            ),
            child: CircleAvatar(
              maxRadius: 4,
              backgroundColor: Styles.textColor,
            ),
          ),
        )
      ]),
    );
  }
}
