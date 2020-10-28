import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime/provider/my_provider.dart';

import 'package:realtime/screen/home_page.dart';

import 'screen/profile_page.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Color(0xff2b2b2b),
          ),
          scaffoldBackgroundColor: Color(0xff2b2b2b)
        ),
        home: ProfilePage(),
      ),
    );
  }
}
