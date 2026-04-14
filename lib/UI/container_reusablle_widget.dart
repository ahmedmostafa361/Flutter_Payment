import 'package:flutter/material.dart';

class ContainerReusablleWidget extends StatelessWidget {
  String image;
  String text1;
  String text2;

  ContainerReusablleWidget({super.key, required this.image,required this.text1,required this.text2,});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(image),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff5e443c).withOpacity(0.85),
        ),
        height: 55,
        width: 135,
        margin: EdgeInsetsGeometry.only(bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [Text(text1), Text(text2)],
        ),
      ),
    );
  }
}
