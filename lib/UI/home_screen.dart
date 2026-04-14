import 'package:flutter/material.dart';
import 'package:food_discovery_flutter/UI/container_reusablle_widget.dart';
import 'package:food_discovery_flutter/model/model.dart';

class HomeScreen extends StatelessWidget {
  static const String homeScreenRoute = 'home';
  HomeScreen({super.key});
  List<ContainerModel> listMenu = [
    ContainerModel(
      image: 'assets/Pasta.png',
      text1: 'Pasta',
      text2: 'Italiano classic',
    ),
    ContainerModel(
      image: 'assets/Sushi.png',
      text1: 'Sushi',
      text2: 'JAPANESE ART',
    ),
    ContainerModel(
      image: 'assets/Pizza.png',
      text1: 'Pizza',
      text2: 'Pizza classic',
    ),
    ContainerModel(
      image: 'assets/Ramen.png',
      text1: 'Ramen',
      text2: 'Ramen classic',
    ),
    ContainerModel(
      image: 'assets/Burger.png',
      text1: 'Burger',
      text2: 'Burger classic',
    ),
    ContainerModel(
      image: 'assets/Steak.png',
      text1: 'Steak',
      text2: 'Steak classic',
    ),
    ContainerModel(
      image: 'assets/Tacos.png',
      text1: 'Tacos',
      text2: 'Tacos classic',
    ),
    ContainerModel(
      image: 'assets/Dim Sum.png',
      text1: 'Dim Sum',
      text2: 'Dim Sum classic',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.menu, color: Color(0xff5D4037),size: 34,),
        ),
        title: Text('Epicurean Finds',style: TextStyle(
          color: Color(0xff5D4037),
          fontWeight: FontWeight.w900,
          fontSize: 24,
        ),),
        centerTitle: true,
        actions: [Icon(Icons.account_circle_rounded, color: Color(0xff5D4037),size: 36,),
        SizedBox(width: 16,)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GLOBAL GASTRONOMY',
                style: TextStyle(
                  color: Color(0xff8D6E63),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: 1
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Signature',
                style: TextStyle(
                  color: Color(0xff5D4037),
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: 12),
              Text('Flavors',
                style: TextStyle(
                  color: Color(0xff8D6E63),
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsetsGeometry.symmetric(vertical: 18),
                itemCount: listMenu.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ContainerReusablleWidget(
                    image: listMenu[index].image,
                    text1: listMenu[index].text1,
                    text2: listMenu[index].text2,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
