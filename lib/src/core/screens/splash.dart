
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/repositories/splash_api.dart';
import 'package:amval/src/presentation/logic/cubit/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => SplashCubit(repository: APISplash()),
          child: BlocConsumer<SplashCubit, SplashState>(
              builder: (context, state){
                if(state is SplashInitial){
                  context.read<SplashCubit>().checkInternet();
                  return const Text("خوش آمدید");
                }
                if(state is SplashInternetCheckInProcess){
                  return const Text("در حال بررسی اتصال اینترنت...");
                }
                if(state is SplashInternetCheckSuccess){
                  return const Text("متصل به اینترنت");
                }
                if(state is SplashInternetCheckFault){
                  return TextButton(
                      onPressed: () {
                        context.read<SplashCubit>().checkInternet();
                      },
                      child: const Text("تلاش مجدد")
                  );
                }
                if(state is SplashCheckAccessToken){
                  return const Text("در حال بررسی ...");
                }
                if(state is SplashNewToken){
                  return const Text("با موفقیت وارد شدید");
                }
                if(state is SplashNoAccessToken){
                  return const Text("در حال انتقال به صفحه ورود");
                }
                return Container();
              },
              listener: (context, state) {
                if (state is SplashInternetCheckSuccess){
                  context.read<SplashCubit>().getNewToken();
                }
                if (state is SplashNewToken){
                  ACCESS_TOKEN = state.newAccess;
                  Navigator.pushReplacementNamed(context, "/dashboard");
                }
                if (state is SplashNoAccessToken){
                  Navigator.pushReplacementNamed(context, "/login");
                }
              },
          ),
        ),
      ),
    );
  }
}

