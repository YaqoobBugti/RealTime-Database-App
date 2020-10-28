import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime/provider/my_provider.dart';
import 'package:realtime/screen/home_page.dart';

class CartPage extends StatelessWidget {
  Widget cartItem({
    @required int count,
    @required String image,
    @required String name,
    @required int price,
    @required Function onTap,
  }) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(image),
            ),
            Expanded(
              child: Container(
                height: 200,
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Unlimited model downloads and",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$$price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " x$count",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: onTap,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provier = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: provier.cartList.length,
        itemBuilder: (context, index) {
          provier.getDeleteIndex(index);
          return cartItem(
            onTap: (){
              provier.delete();
            },
            image: provier.cartList[index].image,
            name: provier.cartList[index].name,
            price: provier.cartList[index].price,
            count: provier.cartList[index].quantity,
          );
        },
      ),
    );
  }
}
