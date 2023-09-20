import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:soulpaws/services/NotificationService.dart';

import 'UserScreens/DrawerScreen.dart';
import 'UserScreens/Favorite/FavoriteCats.dart';
import 'UserScreens/Favorite/FavoriteDogs.dart';
import 'UserScreens/HomeScreen.dart';
import 'UserScreens/ListView/CatListView.dart';
import 'UserScreens/ListView/DogListView.dart';
import 'UserScreens/Payment.dart';
import 'UserScreens/adoption.dart';
import 'UserScreens/auth/SplashScreen.dart';
import 'UserScreens/auth/ForgetPassword.dart';
import 'UserScreens/auth/UserLogin.dart';
import 'UserScreens/auth/UserRegistration.dart';
import 'UserScreens/auth/account_screen.dart';
import 'UserScreens/subpages/subScreen.dart';
import 'UserScreens/subpages/subScreenCat.dart';
import 'UserScreens/veterinaty.dart';
import 'ViewModel/AdoptViewModel.dart';
import 'ViewModel/CatViewModel.dart';
import 'ViewModel/DogViewModel.dart';
import 'ViewModel/GlobalUIViewModel.dart';
import 'ViewModel/SingleDogViewModel.dart';
import 'ViewModel/auth_viewmodel.dart';
import 'ViewModel/favoriteCatViewModel.dart';
import 'ViewModel/favoriteDogViewModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  NotificationService.initialize();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider<DogViewModel>(create: (_) => DogViewModel()),
          ChangeNotifierProvider<CatViewModel>(create: (_) => CatViewModel()),
          ChangeNotifierProvider(create: (_) => FavoriteDogViewModel()),
          ChangeNotifierProvider(create: (_) => FavoriteCatViewModel()),
          ChangeNotifierProvider(create: (_) => AdoptionViewModel()),
          ChangeNotifierProvider<SingleDogViewModel>(
              create: (_) => SingleDogViewModel()),
        ],
        child: MaterialApp(

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          initialRoute: "/splash",
          routes: {
            "/splash": (context) => Splash(),
            "/UserLogin": (context) => UserLogin(),
            "/ForgotPassword": (context) => ForgetPasswordScreen(),
            "/Registration": (context) => UserRegistration(),
            "/dashboard": (context) => HomePage(),
            "/CatCategory": (context) => CatListView(),
            "/DogCategory": (context) => DogListView(),
            "/SubPage": (context) =>
                SubScreen(null, null, null, null, null, null, null),
            "/SubPageCat": (context) =>
                SubScreenCat(null, null, null, null, null, null, null),
            "/FavoriteDogs": (context) => FavoriteDog(),
            "/FavoriteCats": (context) => FavoriteCat(),
            "/Profile": (context) => AccountScreen(),
            "/Adoption": (context) => Adoption(),
            "/HomeScreen":(context) => HomeScreen(),
            "/Payment":(context) =>KhaltiPayment(),
            "/Veterinary":(context) =>Veterinary(),
          },
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [DrawerScreen(), HomeScreen()],
      ),
      // body: SubScreen(),
    );
  }
}
