import 'package:EvNav/Auth/HomePage.dart';
import 'package:EvNav/Auth/loginPage.dart';
import 'package:EvNav/99Data.dart';
import 'package:EvNav/Providers/favStation.dart';
import 'package:EvNav/Screens/Extra_Screens/booking.dart';
import 'package:EvNav/Screens/Extra_Screens/profile.dart';
import 'package:EvNav/Screens/Intro/SplashScreen.dart';
import 'package:EvNav/WelcomePage.dart';
import 'package:EvNav/99dependency_injection.dart';
import 'package:EvNav/navBar/99animatedNavBar.dart';
import 'package:EvNav/tab_contents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:EvNav/Providers/chData.dart';
import 'package:connectivity/connectivity.dart';

import 'package:EvNav/Screens/CarSelection/carSelection.dart';

import 'package:EvNav/Screens/CarSelection/carSelect.dart';
//import 'package:effecient/Screens/Extra_Screens/intro1.dart';

import 'package:EvNav/Screens/Intro/intro_screen.dart';

import 'package:EvNav/Screens/PortSelection/EvPortSelectionScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //MAIN
  //runApp(MyApp(initialScreen: LoginPage()));
  // Preview the WelcomePage directly
  //runApp(MyApp(initialScreen: HomePage(user: User,)));

  // runApp(MyApp(initialScreen: MapScreen()));

  //runApp(MyApp(initialScreen: ProfileScreen()));

  //runApp(MyApp(initialScreen: CarSelect()));
  //runApp(MyApp(initialScreen: IntroScreen()));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => chDataProvider()),
      ChangeNotifierProvider(create: (context) => FavoriteStationsProvider())
    ],
    child: MyApp(
      initialScreen: SplashScreen(),

      // For Navigationbar checking
      // initialScreen: BottonNavWithAnimatedIcons(),
    ), // Your app's main widget
  ));
  // DependencyInjection.init();
  // runApp(ChangeNotifierProvider(
  //   // Create an instance of YourDataProvider
  //   create: (context) => chDataProvider(),

  //   child: MyApp(initialScreen: SplashScreen()), // Your app's main widget
  // ));
  // runApp(MyApp(
  //     initialScreen: CurvedNavigationBar(
  //   items: [],
  // )));

  //runApp(MyApp(initialScreen: CarSelection()));

  //runApp(MyApp(initialScreen: EvPortSelectionScreen()));
}

class MyApp extends StatefulWidget {
  final Widget initialScreen;

  const MyApp({required this.initialScreen, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? loggedInUser;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _hasSeenIntroSignupKey = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    //     useMaterial3: true,
    //   ),
    //   home: widget.initialScreen,
    //   routes: {'/reservations': (context) => ReservationScreen()},
    // );
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data == ConnectivityResult.mobile ||
              snapshot.data == ConnectivityResult.wifi) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
              ),
              home: widget.initialScreen,
              routes: {'/reservations': (context) => ReservationScreen()},
            );
          } else {
            return Directionality(
                // Set textDirection based on your app's language (optional)
                textDirection: TextDirection.ltr, // Left-to-right by default
                child: Stack(
                  children: [
                    LoadingScreen(),
                    const Positioned(
                      // top: 25,
                      // left: 0,
                      // right: 0,

                      child: noInternet(), // your loading button here
                    )
                  ],
                ));
          }
        });
  }
}

class noInternet extends StatefulWidget {
  const noInternet({Key? key}) : super(key: key);

  @override
  _noInternetState createState() => _noInternetState();
}

class _noInternetState extends State<noInternet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.7),
        child: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 50.0,
              color: Colors.red,
            ),
            Text(
              'No internet connection!  and  Please turn On the Location',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        )));
  }
}
