import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// tokens
late String ACCESS_TOKEN;
late String REFRESH_TOKEN;

// API
const String baseUrl = "https://amval.karbabar.ir";

// colors
const Color? appBarColor = Color.fromRGBO(188, 188, 188, 1);
const Color? backGroundColor = Color.fromRGBO(242,239,249, 1);
const Color? fieldColor = Color.fromRGBO(245, 245, 246, 1);
const Color? buttonColor = Color.fromRGBO(206, 147, 216, 1);
const Color? containerColor = Color.fromRGBO(102, 106, 209, 1);


// picture
String capturePath = "";

// duration
Duration durationForErrorMessage = const Duration(seconds: 3);
Duration durationForSuccessMessage = const Duration(seconds: 4);

// functions

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }
  return input;
}

// camera
late CameraDescription camera;
