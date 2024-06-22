import 'package:flutter/material.dart';
import 'package:appgmp/home_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:flutter_home_rent_app/menu_page.dart';
// import 'package:flutter_home_rent_app/zoom_home_page.dart';
// import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Change here
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}




