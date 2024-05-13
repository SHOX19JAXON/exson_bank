import 'package:exson_bank/bloc/auth/auth_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/auth/auth_bloc.dart';

import '../bloc/card_bloc/card2_bloc.dart';
import '../bloc/card_bloc/card2_event.dart';
import '../bloc/history/history_bloc.dart';
import '../bloc/transaction/transaction_bloc.dart';

import '../bloc/user_profile/user_profile_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/card_repository2.dart';

import '../data/repositories/history2.dart';
import '../data/repositories/user_profil_repository.dart';
import '../screen/lokal_auth/methot_one/cubit/check_cubit.dart';
import '../screen/lokal_auth/methot_one/cubit/passwor_cubit.dart';
import '../screen/routs.dart';
import '../screen/tab/history/history_screen.dart';
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
        RepositoryProvider(
          create: (_) => CardsRepository(),
        ),
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

          BlocProvider(create: (_) => PasswordCubit()),
          BlocProvider(create: (_) => CheckCubit()),
          BlocProvider(
            create: (context) => UserCardsBloc(
              cardsRepository: context.read<CardsRepository>(),
            )

              ..add(GetCardsDatabaseEvent())
              ..add(GetActiveCards()),
          ),
          BlocProvider(
            create: (context) => TransactionBloc(
              cardsRepository: context.read<CardsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryBloc( repository: HistoriesRepository()), // Bloc ni yaratamiz
            child: HistoryScreen(),
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
