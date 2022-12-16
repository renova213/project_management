import 'package:final_project/view_models/auth_view_model.dart';
import 'package:final_project/view_models/botnavbar_view_model.dart';
import 'package:final_project/view_models/profil_view_model.dart';
import 'package:final_project/view_models/tabbar_view_model.dart';
import 'package:final_project/view_models/workspace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'views/splash/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TabBarViewModel()),
        ChangeNotifierProvider(create: (_) => WorkspaceViewModel()),
        ChangeNotifierProvider(create: (_) => ProfilViewModel()),
        ChangeNotifierProvider(create: (_) => BotnavbarViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
