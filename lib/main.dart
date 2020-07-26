import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviehub/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(TheMovieHub());
}

class TheMovieHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black12),
      home: HomeScreen(),
    );
  }
}
