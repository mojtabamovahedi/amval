part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashInternetCheckInProcess extends SplashState {}
class SplashInternetCheckFault extends SplashState {}
class SplashInternetCheckSuccess extends SplashState {}
class SplashCheckAccessToken extends SplashState {}
class SplashNoAccessToken extends SplashState {}
class SplashNewToken extends SplashState {
  String newAccess;

  SplashNewToken({required this.newAccess});
}