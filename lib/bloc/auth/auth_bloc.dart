import 'package:exson_bank/bloc/auth/auth_state.dart';
import 'package:exson_bank/data/model/forma_stats.dart';
import 'package:exson_bank/data/model/network_respons.dart';
import 'package:exson_bank/data/model/user_model.dart';
import 'package:exson_bank/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(
    AuthState(
      errorMessage: "",
      statusMessage: "",
      formStatus: FormsStatus.pure,
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
    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
    await authRepository.loginWithEmailAndPassword(
      email: "${event.username}@gmail.com",
      password: event.password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormsStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          formStatus: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(state.copyWith(formStatus: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(formStatus: FormsStatus.authenticated));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));

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
          formStatus: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _logOutUser(LogOutEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await authRepository.logOutUser();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormsStatus.unauthenticated));
    } else {
      emit(
        state.copyWith(
          formStatus: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _googleSigIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));
    NetworkResponse networkResponse = await authRepository.googleSignIn();

    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          formStatus: FormsStatus.authenticated,
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
          formStatus: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }
}

