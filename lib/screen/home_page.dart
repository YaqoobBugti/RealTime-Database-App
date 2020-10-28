import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime/modle/category_modle.dart';
import 'package:realtime/modle/food_modle.dart';
import 'package:realtime/provider/my_provider.dart';
import 'package:realtime/screen/categories.dart';
import 'package:realtime/screen/detail_page.dart';
import 'package:realtime/widget/botton_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModle> burgerList = [];
  List<CategoryModle> pizzaList = [];
  List<CategoryModle> drinkList = [];
  List<CategoryModle> recipeList = [];
  List<FoodModle> foodList = [];
  List<FoodModle> burgerCategoriesList = [];
  List<FoodModle> pizzaCategoriesList = [];
  List<FoodModle> drinkCategoriesList = [];
  List<FoodModle> recipeCategoriesList = [];
  Widget categoriesContainer(
      {@required String image, @required String name, Function ontap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image)),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget drawerItem({@required String name, @required IconData icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget burger() {
    return Row(
      children: burgerList
          .map(
            (e) => categoriesContainer(
              ontap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: burgerCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name,
            ),
          )
          .toList(),
    );
  }

  //////////////2nd /////////////
  Widget pizza() {
    return Row(
      children: pizzaList
          .map(
            (e) => categoriesContainer(
              ontap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: pizzaCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name,
            ),
          )
          .toList(),
    );
  }

  ////////3rd /////////////////
  Widget drink() {
    return Row(
      children: drinkList
          .map(
            (e) => categoriesContainer(
              ontap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: drinkCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name,
            ),
          )
          .toList(),
    );
  }

  ///////////////4th//////////////////
  Widget recipe() {
    return Row(
      children: recipeList
          .map(
            (e) => categoriesContainer(
              ontap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: recipeCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    provider.getBurger();
    burgerList = provider.throwBurgerList;
    provider.getFoodData();
    foodList = provider.throwFoodList;
    provider.getBurgerCategories();
    pizzaList = provider.throwPizzaList;
    provider.getDrink();
    provider.getRecipe();
    recipeList = provider.throwRecipeList;
    drinkList = provider.throwDrinkList;
    provider.getPizzaCategories();
    pizzaCategoriesList = provider.throwPizzaCategoriesList;
    provider.getPizza();
    burgerCategoriesList = provider.throwBurgerCategoriesList;
    provider.getDrinkCategories();
    drinkCategoriesList = provider.throwDrinkCategoriesList;
    provider.getRecipeCategories();
    recipeCategoriesList = provider.throwRecipeCategoriesList;
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff2b2b2b),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    //   // image: AssetImage('images/background.jpg'),
                    // ),
                  ),
                  currentAccountPicture: CircleAvatar(
                      // backgroundImage: AssetImage('images/profile.jpg'),
                      ),
                  accountName: Text("Flutter Baba"),
                  accountEmail: Text("AqeelBaloch@gmail.com"),
                ),
                drawerItem(icon: Icons.person, name: "Profile"),
                drawerItem(icon: Icons.add_shopping_cart, name: "Cart"),
                drawerItem(icon: Icons.shop, name: "Order"),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                ListTile(
                  leading: Text(
                    "Comunicate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                // Text(
                //   "Comunicate",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20,
                //   ),
                // ),
                drawerItem(icon: Icons.lock, name: "Change"),
                drawerItem(icon: Icons.exit_to_app, name: "Log Out"),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              provider.burger();
            },
          )
          // Padding(
          //   padding: const EdgeInsets.all(9.0),
          //   child: CircleAvatar(
          //     // backgroundImage: AssetImage('images/profile.jpg'),
          //   ),
          // )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search Food",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Color(0xff3a3e3e),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                burger(),
                pizza(),
                drink(),
                recipe(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 510,
            child: GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: foodList
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
                        price: e.price,
                        name: e.name,
                      ),
                    )
                    .toList()),
          )
        ],
      ),
    );
  }
}
