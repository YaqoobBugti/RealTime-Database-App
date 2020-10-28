import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime/provider/my_provider.dart';
import 'package:realtime/screen/cart_page.dart';
import 'package:realtime/screen/home_page.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String name;
  final int price;
  DetailPage({@required this.image, @required this.name, @required this.price});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    MyProvider provider=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff3a3e3e),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 40,
                                width: 40,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 40,
                                width: 40,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${widget.price * count}",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    ),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "With The days of calling into a restaurant to speak with a rude host are finally over. Whether if it’s constantly being put on hold or having to scream your order through the deafening background noise, ordering food has been and always be a hassle.just a few taps on the screen, we now have access to hundreds or new and delicious restaurants ranging from every cuisine you can think of. And they’re just getting started 🙂",
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xff2b2b2b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_basket,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add To Cart",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                        onPressed: () {
                          provider.addToCart(
                            image: widget.image,
                            name: widget.name,
                            price: widget.price,
                            quantity: count
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
