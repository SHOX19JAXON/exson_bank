import 'package:exson_bank/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/user_card_bloc/user_card_bloc.dart';
import '../bloc/user_card_bloc/user_card_event.dart';
import '../bloc/user_profile/user_profile_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/card_repostory.dart';
import '../data/repositories/user_profil_repository.dart';
import '../screen/lokal_auth/methot_one/cubit/check_cubit.dart';
import '../screen/lokal_auth/methot_one/cubit/passwor_cubit.dart';
import '../screen/routs.dart';
import '../service/locol_natifacation_service.dart';

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
        RepositoryProvider(create: (_) => CardRepository()),
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
          BlocProvider(
            create: (context) => UserCardsBloc(
              cardRepository: context.read<CardRepository>(),
            )..add(GetCardsDatabaseEvent()),
          ),
          BlocProvider(create: (_) => PasswordCubit()),
          BlocProvider(create: (_) => CheckCubit()),
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
