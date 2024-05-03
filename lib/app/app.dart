import 'package:exson_bank/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/user_profile/user_profile_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/user_profil_repository.dart';
import '../screen/routs.dart';
import '../service/locol_natifacation_service.dart';

// class App extends StatelessWidget {
//   App({super.key});
//
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     LocalNotificationService.localNotificationService.init(navigatorKey);
//
//     return MultiRepositoryProvider(
//       providers: [RepositoryProvider(create: (_) => AuthRepository())],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => UserProfileBloc(
//                 userProfileRepository: context.read<UserProfileRepository>()),
//           ),
//           BlocProvider(
//             create: (context) => AuthBloc(
//               authRepository: context.read<AuthRepository>(),
//             )..add(CheckAuthenticationEvent())
//           ),
//         ],
//         child: ScreenUtilInit(
//           designSize: const Size(375, 812),
//           builder: (context, child) {
//             ScreenUtil.init(context);
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               initialRoute: RouteNames.splashScreen,
//               navigatorKey: navigatorKey,
//               onGenerateRoute: AppRoutes.generateRoute,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserProfileRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            AuthBloc(authRepository: context.read<AuthRepository>())
              ..add(CheckAuthenticationEvent()),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(
                userProfileRepository: context.read<UserProfileRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}