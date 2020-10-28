import 'package:flutter/material.dart';
import 'package:realtime/modle/food_modle.dart';
import 'package:realtime/screen/detail_page.dart';
import 'package:realtime/screen/home_page.dart';
import 'package:realtime/widget/botton_container.dart';

class Categories extends StatelessWidget {
  List<FoodModle> list = [];
  Categories({@required this.list});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
        body: GridView.count(
          shrinkWrap: false,
          primary: false,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: list
              .map(
                (e) => BottomContainer(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  image: e.image,
                  name: e.name,
                  price: e.price,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
