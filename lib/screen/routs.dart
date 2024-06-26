import 'package:exson_bank/screen/no_internet/no_internet.dart';
import 'package:exson_bank/screen/on_bording/on_bording.dart';
import 'package:exson_bank/screen/paymaent/paymey_screen.dart';
import 'package:exson_bank/screen/splash/splash.dart';
import 'package:exson_bank/screen/tab/card/add_card_screen2.dart';
import 'package:exson_bank/screen/tab/card/add_screen/add_screen.dart';
import 'package:exson_bank/screen/tab/tab_screen.dart';
import 'package:exson_bank/screen/transfer/transfer_screen.dart';
import 'package:flutter/material.dart';

import 'auth_screens/register_screen.dart';




class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.noInternetRoute:
        return navigate(NoInternetScreen(
            onInternetComeBack: settings.arguments as VoidCallback));

      case RouteNames.transferRoute:
        return navigate(const TransferScreen());
      case RouteNames.paymentRoute:
        return navigate(const PaymentScreen());
      case RouteNames.authRoute:
        return navigate(const RegisterScreen());
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
      case RouteNames.addCardScreen:
        return navigate(const AddCardScreen());

      case RouteNames.addCardRoute:
        return navigate(const AddCardScreen());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String authRoute = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String addCardScreen = "/add_card_screen";

  static const String addCardRoute = "/add_card_route";
}