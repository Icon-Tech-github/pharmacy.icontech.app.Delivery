import 'package:countup/countup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../bloc/auth_bloc/auth_cubit.dart';
import '../../bloc/home_bloc/order_cubit.dart';
import '../../data/ServerConstants.dart';
import '../../data/reposetories/auth_repo.dart';
import '../../local_storage.dart';
import '../../theme.dart';
import '../../translations/locale_keys.g.dart';
import '../screens/change_pass.dart';
import '../screens/login.dart';
import 'default_button.dart';
import 'loading.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String text = "";
    int maxLength = 20;

    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ServerConstants.showDialog1(context, state.error);
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.logout_success.tr()),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (BuildContext context) => AuthCubit(AuthRepo()),
                  child: LoginScreen(),
                ),
              ),
            );
          } else if (state is AuthLoading) {
            LoadingScreen.show(context);
          }
        },
        builder: (context, state) => Drawer(
              width: size.width * .8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * .42,
                    width: double.infinity,
                    color: AppTheme.kPrimary,
                    child: SafeArea(
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * .2,
                                  height: size.width * .2,
                                  decoration: BoxDecoration(
                                      color: AppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            LocalStorage.getData(
                                                    key: "image") ??
                                                ""),
                                      ),
                                      border: Border.all(
                                          color: Colors.white, width: 3)),
                                ),
                                SizedBox(
                                  width: size.width * .04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (LocalStorage.getData(key: "userName")?.length ?? 0) > 10
                                          ? (LocalStorage.getData(key: "userName")?.substring(0, 10) ?? "") + "..."
                                          : (LocalStorage.getData(key: "userName") ?? ""),
                                      style: TextStyle(
                                        height: size.height * .002,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .065,
                                        letterSpacing: 0.18,
                                        color: AppTheme.white,
                                      ),
                                    ),
                                    Text(LocalStorage.getData(key: "phone"),
                                        style: TextStyle(
                                          // fontFamily: fontName,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: size.width * .03,
                                          letterSpacing: 0.18,
                                          height: size.height * .001,

                                          color: AppTheme.white,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.done_outline_outlined,
                                    size: size.height * .05,
                                    color: Colors.white,
                                  ),
                                  Countup(
                                    begin: 0,
                                    end: double.parse(
                                        OrderCubit.deliveredOrders.toString()),
                                    curve: Curves.easeOut,
                                    duration: Duration(seconds: 1),
                                    separator: ',',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .07,
                                      letterSpacing: 0.18,
                                      height: size.height * .003,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(LocaleKeys.success.tr(),
                                      style: TextStyle(
                                        // fontFamily: fontName,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .04,
                                        letterSpacing: 0.18,
                                        height: size.height * .00001,
                                        color: Colors.white.withOpacity(.5),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/close.png",
                                    height: size.height * .04,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  Countup(
                                    begin: 0,
                                    end: double.parse(
                                        OrderCubit.refusedOrders.toString()),
                                    curve: Curves.easeOut,
                                    duration: Duration(seconds: 1),
                                    separator: ',',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .07,
                                      letterSpacing: 0.18,
                                      height: size.height * .003,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  // Text("5",
                                  //     style: TextStyle(
                                  //       // fontFamily: fontName,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: size.width * .07,
                                  //       letterSpacing: 0.18,
                                  //       height:  size.height * .003,
                                  //       color: AppTheme.nearlyBlack,
                                  //     )),
                                  Text(LocaleKeys.rejected.tr(),
                                      style: TextStyle(
                                        // fontFamily: fontName,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .04,
                                        letterSpacing: 0.18,
                                        height: size.height * .00001,
                                        color: Colors.white.withOpacity(.5),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.warning_amber_outlined,
                                    size: size.height * .05,
                                    color: Colors.white,
                                  ),
                                  //   Image.asset("assets/images/failed.png",height: size.height * .06,color: Colors.white,),
                                  Countup(
                                    begin: 0,
                                    end: double.parse(
                                        OrderCubit.failedOrders.toString()),
                                    curve: Curves.easeOut,
                                    duration: Duration(seconds: 1),
                                    separator: ',',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .07,
                                      letterSpacing: 0.18,
                                      height: size.height * .003,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(LocaleKeys.failed.tr(),
                                      style: TextStyle(
                                        // fontFamily: fontName,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .04,
                                        letterSpacing: 0.18,
                                        height: size.height * .00001,
                                        color: Colors.white.withOpacity(.5),
                                      )),
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.stats.tr(),
                                    style: TextStyle(
                                      fontSize: size.width * .045,
                                      letterSpacing: 0.18,
                                      height: size.height * .001,
                                      color: AppTheme.white.withOpacity(.4),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                    style: TextStyle(
                                      fontSize: size.width * .045,
                                      letterSpacing: 0.18,
                                      height: size.height * .001,
                                      color: AppTheme.white.withOpacity(.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              (LocalStorage.getData(key: "lastStatus") ??
                                          true) ==
                                      true
                                  ? Icons.wifi_tethering_rounded
                                  : Icons.portable_wifi_off_outlined,
                              color: AppTheme.kPrimary,
                            ),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Text(LocaleKeys.available.tr(),
                                style: TextStyle(
                                  // fontFamily: fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * .05,
                                  letterSpacing: 0.18,
                                  color: AppTheme.darkerText,
                                )),
                          ],
                        ),
                        FlutterSwitch(
                          width: size.width * .18,
                          height: size.height * .04,
                          activeColor: AppTheme.kPrimary,
                          //valueFontSize: 20.0,
                          toggleSize: 25.0,
                          value:
                              LocalStorage.getData(key: "lastStatus") ?? true,
                          borderRadius: 30.0,
                          padding: 4.0,
                          // showOnOff: true,
                          onToggle: (val) async {
                            print(LocalStorage.getData(key: "lastStatus"));
                            await context.read<AuthCubit>().available(context);
                            // setState(() {
                            //   //   context.read<AuthCubit>().availability = val;
                            // });
                            print(LocalStorage.getData(key: "lastStatus"));
                          },
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (context.locale.toString() == 'ar') {
                        LocalStorage.saveData(key: "lang", value: 'en');
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("lang", "en");
                        await context.setLocale(
                          Locale("en"),
                        );
                        //  OrderCubit.categoryNum ==1;
                      } else {
                        LocalStorage.saveData(key: "lang", value: 'ar');

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("lang", "ar");
                        await context.setLocale(
                          Locale("ar"),
                        );
                        //    OrderCubit.categoryNum ==1;
                      }
                      context.read<AuthCubit>().changeLang();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: AppTheme.kPrimary,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(LocaleKeys.language_translate.tr(),
                              style: TextStyle(
                                // fontFamily: fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .05,
                                letterSpacing: 0.18,
                                color: AppTheme.darkerText,
                              )),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<AuthCubit>(
                                create: (BuildContext context) =>
                                    AuthCubit(AuthRepo()),
                                child: ChangePassScreen()),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_open,
                            color: AppTheme.kPrimary,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(LocaleKeys.change_pass_translate.tr(),
                              style: TextStyle(
                                // fontFamily: fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .05,
                                letterSpacing: 0.18,
                                color: AppTheme.darkerText,
                              )),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: size.height * .3,),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().logout();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppTheme.kPrimary,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(LocaleKeys.logout.tr(),
                              style: TextStyle(
                                // fontFamily: fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .05,
                                letterSpacing: 0.18,
                                color: AppTheme.darkerText,
                              )),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (modal) {
                          var we = MediaQuery.of(context).size.width;
                          var he = MediaQuery.of(context).size.height;
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              content:
                                  // StatefulBuilder(
                                  //   builder: (BuildContext context, StateSetter setState) {
                                  //     return
                                  BlocProvider.value(
                                      value:
                                          BlocProvider.of<AuthCubit>(context),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: he * .01,
                                          ),
                                          Text(
                                            LocaleKeys.delete_account.tr(),
                                            style: TextStyle(
                                              color: AppTheme.orange,
                                              fontSize: we * .04,
                                              height: he * .003,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            LocaleKeys.delete_account_msg.tr(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: we * .035,
                                              height: he * .002,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: he * .02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: we * .28,
                                                child: DefaultButton(
                                                  height: he * .06,
                                                  width: we + .3,
                                                  textColor: Colors.white,
                                                  color: Colors.red,
                                                  title: LocaleKeys.ok_translate
                                                      .tr(),
                                                  radius: 15,
                                                  function: () async {
                                                    //  context.read<AuthCubit>().deleteAcount();
                                                    await BlocProvider.of<
                                                            AuthCubit>(context)
                                                        .deleteAcount(
                                                            // phone: phone,
                                                            // password: password,
                                                            );
                                                  },
                                                  font: he * 0.02,
                                                ),
                                              ),
                                              SizedBox(
                                                width: we * .28,
                                                child: DefaultButton(
                                                  height: he * .06,
                                                  width: we * .3,
                                                  textColor: Colors.white,
                                                  color: Colors.green,
                                                  title: LocaleKeys.cancel.tr(),
                                                  radius: 15,
                                                  function: () {
                                                    Navigator.pop(context);
                                                  },
                                                  font: he * 0.02,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                              //   }
                              //
                              // ),
                              );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_circle_outline,
                            color: AppTheme.kPrimary,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(LocaleKeys.delete_account.tr(),
                              style: TextStyle(
                                // fontFamily: fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .05,
                                letterSpacing: 0.18,
                                color: AppTheme.darkerText,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
