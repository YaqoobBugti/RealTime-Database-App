import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController email = TextEditingController();

  Widget button({@required Function ontap}) {
    return Container(
      height: 65,
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          "Update",
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

  Widget filledContainer({@required String text}) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Color(0xff3a3e3e),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 17, left: 20),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:180,
                width: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/farhan.png')),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              Container(
                height: 360,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    filledContainer(text: 'firstName'),
                    filledContainer(text: 'secondName'),
                    filledContainer(text: 'Email'),
                  ],
                ),
              ),
              button(
              ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
