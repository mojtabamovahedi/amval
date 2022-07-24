import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/core/screens/dashboard.dart';
import 'package:amval/src/presentation/logic/cubit/is_visible_password_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          saveRefreshToken(state.response.refresh.toString());
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
            content: Text(state.message), duration: durationForErrorMessage,));
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'ورود به نرم‌افزار',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "نام کاربری",
                        hintStyle: TextStyle(fontSize: 12.0),
                        fillColor: fieldColor,
                        filled: true,
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'نام کاربری نباید خالی باشد';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.5,
                    ),
                    BlocProvider(
                      create: (context) => IsVisiblePasswordCubit(),
                      child: BlocBuilder<IsVisiblePasswordCubit, bool>(
                        builder: (context, state) {
                          return TextFormField(
                            obscureText: state,
                            textAlign: TextAlign.right,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    context.read<IsVisiblePasswordCubit>()
                                        .changeVisibility(!state);
                                  },
                                  icon: state
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              border: const OutlineInputBorder(),
                              hintText: "رمزعبور",
                              hintStyle: const TextStyle(fontSize: 12.0),
                              fillColor: fieldColor,
                              filled: true,
                            ),
                            validator: (password) {
                              if (password!.isEmpty) {
                                return "رمز عبور نباید خالی باشد";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().loginButtonPressed(
                                  username: _usernameController.text,
                                  password: _passwordController.text,);
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: state is LoginLoading
                                  ? Center(
                                  child: LoadingAnimationWidget.waveDots(
                                      color: Colors.white, size: 25))
                                  : const Center(
                                child: Text(
                                  "ورود",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh", refreshToken);
    print("this is ${prefs.getString("refresh")}");
  }
}
