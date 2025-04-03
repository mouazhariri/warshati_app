import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:warshati/src/application/router/app_routes.dart';
import 'package:warshati/src/resourses/assets_manager/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final GifController _controller = GifController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Gif(
          image: AssetImage(AppGif.splashLogo),
          controller: _controller,
          fps: 30,
          autostart: Autostart.once,
          onFetchCompleted: () async {
            _controller.reset();
            _controller.forward();
            await Future.delayed(Duration(seconds: 3))
                .then((_) => context.pushReplacement(AppRoutes.signInScreen));
            // context.pushReplacementNamed(AppRoutes.signInScreen);
          },
        ),
      ),
    );
  }
}
