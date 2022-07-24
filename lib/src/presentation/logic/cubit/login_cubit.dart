import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/Login_response.dart';
import 'package:amval/src/data/repositories/login_api.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  APILogin repository;
  LoginCubit({required this.repository}) : super(LoginInitial());

  void loginButtonPressed({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      LoginResponse loginResponse =
          await repository.login(username, password);

      // add access and refresh token to constants
      ACCESS_TOKEN = loginResponse.access.toString();
      REFRESH_TOKEN = loginResponse.refresh.toString();

      emit(LoginSuccess(response: loginResponse));
    } catch (e) {
      emit(LoginFailure(message: '$e'));
    }
  }
}
