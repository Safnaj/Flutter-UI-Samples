class SlideTile{
  final int position;
  final double height;
  final String imagePath;
  final String title;
  final String desc;

  SlideTile(
      this.position,
      {
        this.height,
        this.imagePath,
        this.title,
        this.desc,
      });
}

List<SlideTile> intro_image = [
  SlideTile(1,
    imagePath: "assets/images/delivery.png",
    title: "We Pick",
    height: 70.0,
    desc:
    "Once you place your order, our representative will call you and a time will be scheduled for the pickup.",
  ),
  SlideTile(2,
    imagePath: "assets/images/tailor.png",
    title: "We Stitch",
    height: 40.0,
    desc:
    "We have skilled and highly professional stitching team, providing you a way to incorporate your individuality to your garments.",
  ),
  SlideTile(3,
    height: 100.0,
    imagePath: "assets/images/dress.png",
    title: "We Deliver",
    desc:
    "After stitching the outfit will be delivered at your place, in next 5 working days.",
  ),
];