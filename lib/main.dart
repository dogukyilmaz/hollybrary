import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Movies');
  await Hive.openBox('Favorites');
  await Hive.openBox('Series');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // like this movie detail page?
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie database',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        // scaffoldBackgroundColor: const Color(0xFF0C0303),
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        primaryColor: Colors.purpleAccent.shade200,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      builder: (context, child) {
        return MediaQuery(
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: child!,
          ),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      home: const BottomNavBar(),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
