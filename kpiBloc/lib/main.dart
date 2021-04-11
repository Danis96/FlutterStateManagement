import 'package:flutter/material.dart';
import 'app/view/homepage/page/homepage_page.dart';
import 'theme/config.dart';
import 'theme/custom_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Artist app',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        themeMode: currentTheme.currentTheme,
        home: HomePage(),
      );
  }
}
//
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
//
// class Person with ChangeNotifier {
//   Person({this.name, this.age});
//
//   String name;
//   int age;
//
//   void increaseAge() {
//     age++;
//     notifyListeners();
//   }
//
//   void changeName() {
//     name = "Gary";
//     notifyListeners();
//   }
//
//   Future<void> countdown() async {
//     Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       age++;
//     });
//     notifyListeners();
//   }
// }
//
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider<Person>(
//           create: (_) => Person(name: 'Yohan', age: 25),
//         ),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     print('Rebuild');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Context extensions'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Consumer<Person>(
//                 builder: (BuildContext context, Person p, Widget child) {
//                   print('object');
//                   return Text(
//                       'context.select: ${p.name}');
//                 },
//               ),
//               Text('${DateTime.now()}'),
//               Text('${context.select((Person p) => p.age)}'),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<Person>().increaseAge();
//         },
//       ),
//     );
//   }
// }
