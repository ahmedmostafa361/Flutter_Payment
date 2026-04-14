import 'package:flutter/material.dart';

class ContainerReusablleWidget extends StatelessWidget {
  String image;
  String text1;
  String text2;

  ContainerReusablleWidget({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image)
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Color(0xff5e443c).withOpacity(0.85),
          border: Border.all(
            color: Colors.white12,width: 2.5
          )
        ),

        height: 55,
        width: 145,
        margin: EdgeInsetsGeometry.only(bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              text1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5
              ),
            ),
          ],
        ),
      ),
    );
  }
}
