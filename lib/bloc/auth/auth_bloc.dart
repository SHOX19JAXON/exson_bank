



import 'package:exson_bank/bloc/auth/auth_state.dart';
import 'package:exson_bank/data/model/forma_stats.dart';
import 'package:exson_bank/data/model/network_respons.dart';
import 'package:exson_bank/data/model/user_model.dart';
import 'package:exson_bank/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc({required this.authRepository})
//       : super(AuthState(
//             userModel: UserModel.initial(),
//             errorMessage: "",
//             statusMessage: "",
//             formStatus: FormStatus.pure)) {
//     on<CheckAuthenticationEvent>(_checkAuthentication);
//     on<LoginUserEvent>(_loginUser);
//     on<RegisterUserEvent>(_registerUser);
//     on<LogOutUserEvent>(_logAutUser);
//     on<SigInWithGoogleEvent>(_googleSigIn);
//   }
//
//   final AuthRepository authRepository;
//
//   _checkAuthentication(CheckAuthenticationEvent evant, emit) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     debugPrint("curreent user");
//
//     if (user == null) {
//       emit(state.copyWith(formStatus: FormStatus.unauthenticated));
//     } else {
//       emit(state.copyWith(formStatus: FormStatus.authenticated));
//     }
//   }
//
//   _loginUser(LoginUserEvent evant, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     NetworkResponse networkResponse =
//         await authRepository.loginInWithEmailAndPassword(
//             email: "${evant.username}@gamil.com", password: evant.password);
//
//     if (networkResponse.errorText.isEmpty) {
//       emit(state.copyWith(formStatus: FormStatus.authenticated));
//     } else {
//       emit(state.copyWith(
//           formStatus: FormStatus.error,
//           errorMessage: networkResponse.errorText));
//     }
//   }
//
//   _registerUser(RegisterUserEvent evant, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     NetworkResponse networkResponse =
//         await authRepository.registerWithEmailAndPassword(
//             email: "${evant.userModel.userName}@gamil.com",
//             password: evant.userModel.password);
//
//     if (networkResponse.errorText.isEmpty) {
//       UserCredential userCredential = networkResponse.data;
//       emit(state.copyWith(
//           formStatus: FormStatus.authenticated,
//           statusMessage: "registered",
//           userModel: evant.userModel));
//     } else {
//       emit(state.copyWith(
//           formStatus: FormStatus.error,
//           errorMessage: networkResponse.errorText));
//     }
//   }
//
//   _logAutUser(LogOutUserEvent evant, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     NetworkResponse networkResponse = await authRepository.logOutUser();
//
//     if (networkResponse.errorText.isEmpty) {
//       emit(state.copyWith(formStatus: FormStatus.unauthenticated));
//     } else {
//       emit(state.copyWith(
//           formStatus: FormStatus.error,
//           errorMessage: networkResponse.errorText));
//     }
//   }
//
//   _googleSigIn(SigInWithGoogleEvent evant, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     NetworkResponse networkResponse = await authRepository.googleSignIn();
//
//     if (networkResponse.errorText.isEmpty) {
//       UserCredential userCredential = networkResponse.data;
//       emit(
//         state.copyWith(
//           formStatus: FormStatus.authenticated,
//           userModel: UserModel(
//               imageUrl: userCredential.user!.photoURL ?? "",
//               email: userCredential.user!.email ?? "",
//               userName: "",
//               lastName: userCredential.user!.displayName ?? "",
//               password: "",
//               phoneNumber: userCredential.user!.phoneNumber ?? "",
//               userId: "",
//               fcm: '',
//               authUid: ''),
//         ),
//       );
//     } else {
//       emit(state.copyWith(
//           formStatus: FormStatus.error,
//           errorMessage: networkResponse.errorText));
//     }
//   }
// }




class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(
    AuthState(
      errorMessage: "",
      statusMessage: "",
      formStatus: FormStatus.pure,
      userModel: UserModel.initial(),
    ),
  ) {
    on<LoginUserEvent>(_loginUser);
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LogOutEvent>(_logOutUser);
    on<RegisterUserEvent>(_registerUser);
    on<SignInWithGoogleEvent>(_googleSigIn);
  }

  Future<void> _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
    await authRepository.loginWithEmailAndPassword(
      email: "${event.username}@gmail.com",
      password: event.password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(state.copyWith(formStatus: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
    await authRepository.registerWithEmailAndPassword(
      username: "${event.userModel.userName}@gmail.com",
      password: event.userModel.password,
    );

    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data as UserCredential;

      UserModel userModel =
      event.userModel.copyWith(authUid: userCredential.user!.uid);
      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _logOutUser(LogOutEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await authRepository.logOutUser();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _googleSigIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    NetworkResponse networkResponse = await authRepository.logOutUser();

    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
          userModel: UserModel(
            imageUrl: userCredential.user!.photoURL ?? "",
            email: userCredential.user!.email ?? "",
            userName: userCredential.user!.displayName ?? "",
            lastName: userCredential.user!.displayName ?? "",
            password: "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            userId: "",
            fcm: "",
            authUid: userCredential.user!.uid,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }
}

