import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/model/moviedetail.dart';
import 'package:movie_app/page/moviedetail_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MoviedetailAdapter());
  await Hive.openBox<Moviedetail>('moviedetails');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Hive Movie App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.light(),
        home: MoviedetailPage(),
      );
}
