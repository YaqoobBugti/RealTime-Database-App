import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realtime/modle/cart_modle.dart';
import 'package:realtime/modle/category_modle.dart';
import 'package:realtime/modle/food_modle.dart';
import 'dart:convert';

import 'package:realtime/screen/home_page.dart';

class MyProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  Future<void> signUp({
    @required String email,
    @required String password,
    @required context,
  }) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDmFf4Gdla1e3a5rUI_dlkDJHFGONn2aFU';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      var responseData = (json.decode(response.body));
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } on HttpException catch (e) {
      if (e.toString().contains('EMAIL_EXISTS')) {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content:
                Text("The email address is already in use by another account."),
          ),
        );
        loading = false;
        return;
      }
      if (e.toString().contains('OPERATION_NOT_ALLOWED')) {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Password sign-in is disabled for this project"),
          ),
        );
        loading = false;
        return;
      }
      if (e.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                "We have blocked all requests from this device due to unusual activity. Try again later."),
          ),
        );
        loading = false;
        return;
      }
    } catch (e) {
      print("network Probles Please try latter");
    }
    loading = false;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    notifyListeners();
  }

  get throwGlobelKey {
    return globalKey;
  }

  final databaseReference = FirebaseDatabase().reference();
  void sendUserData(
      {@required String firstName,
      @required String email,
      @required String password}) {
    databaseReference.child("userData").push().set({
      'firstName': firstName,
      'email': email,
      'password': password,
    });
  }

  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);

  void validation({
    @required TextEditingController firstName,
    @required TextEditingController email,
    @required TextEditingController password,
    @required context,
  }) {
    if (firstName.text.trim().isEmpty || firstName.text == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(content: Text('First Name Is Empty')),
      );
      return;
    }
    if (email.text.isEmpty || email.text == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Enter Valid Email Address'),
      ));
      return;
    }
    if (password.text.isEmpty || password.text == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
      return;
    } else if (password.text.length < 8) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password too Sort"),
        ),
      );
      return;
    } else {
      loading = true;
      signUp(
        context: context,
        email: email.text,
        password: password.text,
      );
      sendUserData(
        firstName: firstName.text,
        email: email.text,
        password: password.text,
      );
      notifyListeners();
    }
  }

  ////////////////////////////////////////////
  bool loading = false;

  Future<void> loginPage({
    @required String email,
    @required String password,
    @required context,
  }) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDmFf4Gdla1e3a5rUI_dlkDJHFGONn2aFU';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      var responseData = (json.decode(response.body));
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } on HttpException catch (e) {
      if (e.toString().contains('EMAIL_NOT_FOUND')) {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                "There is no user record corresponding to this identifier. The user may have been deleted."),
          ),
        );
        loading = false;
        notifyListeners();
        return;
      }
      if (e.toString().contains('INVALID_PASSWORD')) {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                "The password is invalid or the user does not have a password."),
          ),
        );
        loading = false;
        notifyListeners();
        return;
      }
      if (e.toString().contains('USER_DISABLED')) {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                " The user account has been disabled by an administrator."),
          ),
        );
        loading = false;
        notifyListeners();
        return;
      }
    } catch (e) {
      print("network Probles Please try latter");
    }
    loading = false;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    notifyListeners();
  }

  void loginValidation({
    @required TextEditingController email,
    @required TextEditingController password,
    @required context,
  }) {
    if (email.text.isEmpty || email.text == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is empty"),
        ),
      );

      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('Enter Valid Email Address'),
      ));

      return;
    }
    if (password.text.isEmpty || password.text == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password is  empty"),
        ),
      );

      return;
    } else if (password.text.length < 8) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password too Sort"),
        ),
      );
      return;
    } else {
      loading = true;
      loginPage(context: context, email: email.text, password: password.text);
      notifyListeners();
    }
  }

  get throwLoding {
    return loading;
  }










  void sendPost() {
    databaseReference.child("Recipe").push().set({
      'image':
          'https://cdn.modpizza.com/wp-content/uploads/2019/10/Maddy.png',
      'name': 'Recipe',
    });
  }

  void secondPost() {
    databaseReference.child("Foods").push().set({
      'image':
          'https://cdn.modpizza.com/wp-content/uploads/2016/11/Lucy-Sunshine.png',
      'name': 'Salad',
      'price':200 
   });
  }
 

  
  void burger() {
    databaseReference.child("RecipeCatagories").push().set({
      'image':
          'https://www.freeiconspng.com/thumbs/recipes-icon-png/recipe-icon-png-14.png',
      'name': 'Recipe',
      'price':120 
   });
  }

 

 List<FoodModle> foodList = [];
  Future<void> getFoodData() async {
    List<FoodModle> newfoodList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/Foods.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newfoodList.add(FoodModle(
          price: proData['price'],
          image: proData['image'],
          name: proData['name'],
        ));
      });
      foodList = newfoodList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwFoodList {
    return foodList;
  }



////////////////1st burger ////////////////////
  List<CategoryModle> burgerList = [];
  Future<void> getBurger() async {
    List<CategoryModle> newBurgerList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/Burger.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newBurgerList.add(CategoryModle(
          image: proData['image'],
          name: proData['name'],
        ));
      });
      burgerList = newBurgerList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwBurgerList {
    return burgerList;
  }
///////////////////// 2nd Pizza   //////////////////

  List<CategoryModle> pizzaList = [];
  Future<void> getPizza() async {
    List<CategoryModle> newPizzaList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/Pizza.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newPizzaList.add(CategoryModle(
          image: proData['image'],
          name: proData['name'],
        ));
      });
      pizzaList = newPizzaList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwPizzaList {
    return pizzaList;
  }


  List<CategoryModle> drinkList = [];
  Future<void> getDrink() async {
    List<CategoryModle> newDrinkList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/Drink.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newDrinkList.add(CategoryModle(
          image: proData['image'],
          name: proData['name'],
        ));
      
      });
      drinkList = newDrinkList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwDrinkList {
    return drinkList;
  }


  List<CategoryModle> recipeList = [];
  Future<void> getRecipe() async {
    List<CategoryModle> newRecipeList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/Recipe.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newRecipeList.add(CategoryModle(
          image: proData['image'],
          name: proData['name'],
        ));
      
      });
      recipeList = newRecipeList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwRecipeList {
    return recipeList;
  }

///////////////////////////categories///////////////////////////
 List<FoodModle> burgerCategoriesList = [];
  Future<void> getBurgerCategories() async {
    List<FoodModle> newBurgerCategoriesList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/burgerCatagories.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newBurgerCategoriesList.add(FoodModle(
          price: proData['price'],
          image: proData['image'],
          name: proData['name'],
        ));
      });
      burgerCategoriesList = newBurgerCategoriesList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwBurgerCategoriesList {
    return burgerCategoriesList;
  }
/////////////////pizza///////////////////////////////////
 List<FoodModle> pizzaCategoriesList = [];
  Future<void> getPizzaCategories() async {
    List<FoodModle> newPizzaCategoriesList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/pizzaCatagories.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newPizzaCategoriesList.add(FoodModle(
          price: proData['price'],
          image: proData['image'],
          name: proData['name'],
        ));
      });
      pizzaCategoriesList = newPizzaCategoriesList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwPizzaCategoriesList {
    return pizzaCategoriesList;
  }

  ////////////////////Drink////////////////////////
  List<FoodModle> drinkCategoriesList = [];
  Future<void> getDrinkCategories() async {
    List<FoodModle> newDrinkCategoriesList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/DrinkCatagories.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newDrinkCategoriesList.add(FoodModle(
          price: proData['price'],
          image: proData['image'],
          name: proData['name'],
        ));
      });
      drinkCategoriesList = newDrinkCategoriesList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwDrinkCategoriesList {
    return drinkCategoriesList;
  }
    ///////////////////  Recipe ////////////////////////
  List<FoodModle> recipeCategoriesList = [];
  Future<void> getRecipeCategories() async {
    List<FoodModle> newRecipeCategoriesList = [];
    const url = 'https://realtimeexample-5ba99.firebaseio.com/RecipeCatagories.json';
    try {
      final reponse = await http.get(url);
      var jsonFile = await json.decode(reponse.body);
      jsonFile.forEach((value, proData) {
        newRecipeCategoriesList.add(FoodModle(
          price: proData['price'],
          image: proData['image'],
          name: proData['name'],
        ));
      });
      recipeCategoriesList = newRecipeCategoriesList;
    } catch (errr) {
      print(errr);
    }
    notifyListeners();
  }
  get throwRecipeCategoriesList {
    return recipeCategoriesList;
  }




  //////////////add to cart///////////////
  List<CartModle> cartList = [];
  CartModle cartModle;
  List<CartModle> cartNewList = [];
  void addToCart(
      {@required String image,
      @required String name,
      @required int price,
      @required int quantity}) {
    cartModle = CartModle(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    cartNewList.add(cartModle);
    cartList = cartNewList;
  }

  get throwCartList {
    return cartList;
  }
  
  int myDeleteIndex;
  void getDeleteIndex(int index) {
    myDeleteIndex = index;
  }
  void delete() {
    cartList.removeAt(myDeleteIndex);
    notifyListeners();
  }
}
