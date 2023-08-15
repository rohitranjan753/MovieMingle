import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Constants/color.dart';
import 'package:moviemingle/Screens/home_screen.dart';
import 'package:moviemingle/provider/favourite_movie_provider%5D.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FavoriteMoviesProvider()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteMoviesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(

          ),

          scaffoldBackgroundColor: Colours.scaffoldBgColor,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
