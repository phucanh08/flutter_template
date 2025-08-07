import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/core/app_router/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final router = AutoRouter.of(context);
  FlutterLogoStyle style = FlutterLogoStyle.markOnly;

  @override
  void initState() {
    super.initState();
    animateLogo();
  }



  void animateLogo() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        style = FlutterLogoStyle.horizontal;
      });
    });

    await Future.delayed(const Duration(seconds: 1));
    router.replace(HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 128,
          style: style,
        ),
      ),
    );
  }
}
