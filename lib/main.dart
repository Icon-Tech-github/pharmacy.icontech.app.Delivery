import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pharmacy_driver/persentation/screens/home.dart';
import 'package:pharmacy_driver/persentation/screens/login.dart';
import 'dart:ui' as ui;
import 'bloc/auth_bloc/auth_cubit.dart';
import 'bloc/home_bloc/order_cubit.dart';
import 'data/reposetories/auth_repo.dart';
import 'data/reposetories/home_repo.dart';
import 'firebase_options.dart';
import 'local_storage.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:html' as html;


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.init();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions.currentPlatform,
  );

  // if (kIsWeb) {
  //   await FirebaseMessaging.instance.setAutoInitEnabled(true);
  //   FirebaseMessaging.instance.getToken().then((token) {
  //     print("Web FCM Token: $token");
  //   });
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Web Notification Received: ${message.notification?.title}\n${message.notification?.body}');
  //     html.window.alert("New Notification: ${message.notification?.title}\n${message.notification?.body}");
  //   });
  // }



  if(LocalStorage.getData(key: "lang") == null)
    LocalStorage.saveData(key: "lang", value:  ui.window.locale.languageCode);
  runApp(EasyLocalization(
      path: "assets/translations",
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale('en'),
      saveLocale: true,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OverlaySupport.global(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,

        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: context.locale.toString() == 'ar'?'NotoSansArabic_Condensed':"Jost"
                "",
            primarySwatch: Colors.blue,
          ),
          home:
          LocalStorage.getData(key: "token") == null?
          BlocProvider(
                create: (BuildContext context) =>
                    AuthCubit(AuthRepo()),
                child: LoginScreen()):

                  MultiBlocProvider(
                    providers: [
                      BlocProvider<OrderCubit>(
                        create: (BuildContext context) =>
                            OrderCubit(GetHomeRepository()),
                      ),
                      BlocProvider<AuthCubit>(
                        create: (BuildContext context) =>
                            AuthCubit(AuthRepo()),
                      ),
                    ],
                    child: HomeScreen(),
                  ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
