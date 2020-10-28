import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime/provider/my_provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  Widget textField(
  {@required String labelText,
   @required bool obscureText,
    @required TextEditingController controller}) {
    return TextField(
      style: TextStyle(
        color: Colors.white
      ),
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

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    GlobalKey globalKey = provider.throwGlobelKey;
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  textField(
                    obscureText: false,
                    controller: firstName,
                    labelText: 'firstName',
                  ),
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
                  Container(
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        provider.validation(
                          email: email,
                          context: context,
                          firstName: firstName,
                          password: password,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
