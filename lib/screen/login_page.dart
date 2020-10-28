import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime/provider/my_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget textField(
      {@required String labelText,
      @required bool obscureText,
      @required TextEditingController controller}) {
    return TextField(
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xff3a3e3e),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget button({@required Function ontap}) {
    return Container(
      height: 65,
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          "Click Hare",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        color: Color(0xff3a3e3e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: ontap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    GlobalKey globalKey = provider.throwGlobelKey;
    loading = provider.throwLoding;
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textField(
                      obscureText: false,
                      controller: email,
                      labelText: 'Email',
                    ),
                    textField(
                      obscureText: true,
                      controller: password,
                      labelText: 'Password',
                    ),
                    loading
                        ? CircularProgressIndicator()
                        : button(
                            ontap: () {
                              provider.loginValidation(
                                email: email,
                                context: context,
                                password: password,
                              );
                            },
                     ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
