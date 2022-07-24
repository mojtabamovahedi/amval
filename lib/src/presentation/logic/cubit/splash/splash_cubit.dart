import 'dart:io';

import 'package:amval/src/data/repositories/splash_api.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  APISplash repository;
  SplashCubit({required this.repository}) : super(SplashInitial());

  void checkInternet() async {
    emit(SplashInternetCheckInProcess());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(SplashInternetCheckSuccess());
      }
    } on DioError catch (e) {
      print("error is ${e.toString()}");
      emit(SplashInternetCheckFault());
    }
  }

  void getNewToken() async {
    emit(SplashCheckAccessToken());
    try{
      String access = await repository.getNewAccessToken();
      emit(SplashNewToken(newAccess: access));
    }catch(e){
      emit(SplashNoAccessToken());
    }

  }
}
