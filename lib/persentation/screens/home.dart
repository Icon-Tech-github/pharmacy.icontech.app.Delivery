import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pharmacy_driver/data/ServerConstants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lottie/lottie.dart'as lottie;

import '../../bloc/auth_bloc/auth_cubit.dart';
import '../../bloc/home_bloc/order_cubit.dart';
import '../../bloc/order_details_bloc/order_details_cubit.dart';
import '../../data/models/order_model.dart';
import '../../data/reposetories/Order_details_repo.dart';
import '../../data/reposetories/auth_repo.dart';
import '../../data/reposetories/home_repo.dart';
import '../../local_storage.dart';
import '../../theme.dart';
import '../../translations/locale_keys.g.dart';
import '../wedgits/category_item.dart';
import '../wedgits/home_drawer.dart';
import '../wedgits/order_item.dart';
import 'order_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime? currentBackPressTime;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  fcmNotification() async {

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
    //   print("33333");
    //
    //   RemoteNotification notification = message.notification!;
    //   AndroidNotification android = message.notification!.android!;
    //
    //   if (notification != null && android != null) {
    //     LocalStorage.getData(key: 'lang') == 'en'?
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         message.data['title_en'],
    //         message.data['description_en'],
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             message.data['title_en'],
    //             message.data['description_en'],
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         )):
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         message.data['title_ar'],
    //         message.data['description_ar'],
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             message.data['title_ar'],
    //             message.data['description_ar'],
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //
    //     if (notification != null) {
    //       showSimpleNotification(
    //           InkWell(
    //             onTap: () {
    //               // Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider<OrderDetailsCubit>(
    //               //     create: (BuildContext context) => OrderDetailsCubit(OrderDetailsRepo(), int.parse(message.data['order_id'].toString())),
    //               //     child: OrderDetailsScreen(client: ,)),));
    //               // push(
    //               //   context,
    //               //   BlocProvider<NotificationCubit>(
    //               //       create: (BuildContext
    //               //       context) =>
    //               //           NotificationCubit(
    //               //               NotificationRepo()),
    //               //       child:
    //               //       NotifyScreen()),
    //               // );
    //             },
    //             child: Container(
    //               height: 65,
    //               child: Padding(
    //                   padding: const EdgeInsets.only(top: 5.0),
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         LocalStorage.getData(key: 'lang') ==
    //                             'en' ? message.data['title_en'] : message
    //                             .data['title_ar'],
    //                         style: TextStyle(
    //                             color: AppTheme.white,
    //                             fontSize: 16,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                       // SizedBox(
    //                       //   height: 5,
    //                       // ),
    //                       // Text(
    //                       //   message.notification!.body!,
    //                       //   style: TextStyle(
    //                       //       color: HomePage.colorGreen,
    //                       //       fontSize: 14,
    //                       //       fontWeight: FontWeight.bold),
    //                       // ),
    //                     ],
    //                   )),
    //             ),
    //           ),
    //           duration: Duration(seconds: 3),
    //           background: AppTheme.kPrimary,
    //           elevation: 3
    //       );
    //       print("kkkkkkkkkkkkkkkk");
    //       OrderCubit.selectedIndex=0;
    //       context.read<OrderCubit>().page=1;
    //       context.read<OrderCubit>().newOrderOnLoad();
    //     }
    //
    //   }
    // });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("FCM message received");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (kIsWeb) {
        print('Web notification received');
        final lang = LocalStorage.getData(key: 'lang') ?? 'en';
        final title = lang == 'en' ? message.data['title_en'] : message.data['title_ar'];
        final body = lang == 'en' ? message.data['description_en'] : message.data['description_ar'];

        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              title,
              body,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );


        showSimpleNotification(
          Text(title, style: TextStyle(color: Colors.white)),
          background: AppTheme.kPrimary,
          elevation: 3,
          duration: Duration(seconds: 3),
        );

        OrderCubit.selectedIndex = 0;
        context.read<OrderCubit>().page = 1;
        context.read<OrderCubit>().newOrderOnLoad();
      }

      if (notification != null && android != null) {
        final lang = LocalStorage.getData(key: 'lang') ?? 'en';
        final title = lang == 'en' ? message.data['title_en'] : message.data['title_ar'];
        final body = lang == 'en' ? message.data['description_en'] : message.data['description_ar'];

        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              title,
              body,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );


        showSimpleNotification(
          Text(title, style: TextStyle(color: Colors.white)),
          background: AppTheme.kPrimary,
          elevation: 3,
          duration: Duration(seconds: 3),
        );

        OrderCubit.selectedIndex = 0;
        context.read<OrderCubit>().page = 1;
        context.read<OrderCubit>().newOrderOnLoad();
      }


          if (notification != null) {
            showSimpleNotification(
                Container(
                  height: 65,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Column(
                        children: [
                          Text(
                            LocalStorage.getData(key: 'lang') ==
                                'en' ? message.data['title_en'] : message
                                .data['title_ar'],
                            style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),

                        ],
                      )),
                ),
                duration: Duration(seconds: 3),
                background: AppTheme.kPrimary,
                elevation: 3
            );
            print("kkkkkkkkkkkkkkkk");
            OrderCubit.selectedIndex=0;
            context.read<OrderCubit>().page=1;
            context.read<OrderCubit>().newOrderOnLoad();
          }

    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
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
        ),
      );
    });

  }
@override
  void initState() {
  fcmNotification();
  super.initState();
  }

  void onWillPop(bool close) {

      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        ServerConstants.snackBar(msg: LocaleKeys.Double_Tap_To_Exit.tr(),context: context);
      } else
        exit(0);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.background,
      endDrawer:HomeDrawer(),
      appBar: AppBar(
        toolbarHeight: size.height * .1,
        backgroundColor: AppTheme.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [

            SizedBox(
              width: size.width * .02,
            ),
            Text("${LocaleKeys.hi.tr()}${LocalStorage.getData(key: "userName")}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * .06,
                  letterSpacing: 0.18,
                  color: AppTheme.darkerText,
                )),
          ],
        ),
      ),
      body:     PopScope(
        canPop: false,
onPopInvoked:  onWillPop,
        child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
          if (state is OrderLoading && state.isFirstFetch|| context.read<OrderCubit>().loading ) {
            return Center(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color(0xFFffffff),
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  OrderCubit.selectedIndex  = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:  OrderCubit.selectedIndex  == 0 ?   AppTheme.kPrimary: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(context.locale.toString() == 'ar'?0:10.r),
                                        bottomLeft: Radius.circular(context.locale.toString() == 'ar'?0:10.r),
                                        topRight: Radius.circular(context.locale.toString() == 'en'?0:10.r),
                                        bottomRight: Radius.circular(context.locale.toString() == 'en'?0:10.r)
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.New.tr(),
                                    style: TextStyle(
                                      color:  OrderCubit.selectedIndex  == 0 ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  OrderCubit.selectedIndex  = 1;
                                });
                              },
                              child: Container(
                                color:  OrderCubit.selectedIndex  == 1 ?  AppTheme.kPrimary : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    LocaleKeys.open.tr(),
                                    style: TextStyle(
                                      color:  OrderCubit.selectedIndex  == 1 ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  OrderCubit.selectedIndex  = 2;
                                });
                              },
                              child: Container(
                                // color: _selectedIndex == 2 ? const Color(0xFF00BAAB) : Colors.transparent,
                                decoration: BoxDecoration(
                                    color:  OrderCubit.selectedIndex  == 2 ?   AppTheme.kPrimary: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(context.locale.toString() == 'en'?0:10.r),
                                        bottomLeft: Radius.circular(context.locale.toString() == 'en'?0:10.r),
                                        topRight: Radius.circular(context.locale.toString() == 'ar'?0:10.r),
                                        bottomRight: Radius.circular(context.locale.toString() == 'ar'?0:10.r)
                                    )                              ),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.history.tr(),
                                    style: TextStyle(
                                      color:  OrderCubit.selectedIndex  == 2 ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: .2.sh,),
                    Center(
                      child: LoadingAnimationWidget.fallingDot(
                        size: 70.h,
                        color: AppTheme.kPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          List<OrderData> orders = [];
          if (state is OrderLoading) {
            orders = state.oldOrders;
          } else if (state is OrderLoaded) {
            orders = state.orders;
          }
          OrderCubit ordersState = context.read<OrderCubit>();
        
          return SafeArea(
            child: SmartRefresher(
          header: WaterDropHeader(),
          controller: context.read<OrderCubit>().controller,
          onLoading: () {
            if(OrderCubit.selectedIndex == 0)
            ordersState.newOrderOnLoad();
            else if(OrderCubit.selectedIndex == 1)
              ordersState.openOrderOnLoad();
            else
              ordersState.closedOrderOnLoad();
          },
          enablePullUp: true,
          enablePullDown: false,
          child: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                        Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                             // _selectedIndex = 0;
                              context.read<OrderCubit>().page = 1;
                              context.read<OrderCubit>().newOrderOnLoad();
                              OrderCubit.selectedIndex = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:  OrderCubit.selectedIndex  == 0 ?   AppTheme.kPrimary: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(context.locale.toString() == 'ar'?0:10.r),
                                    bottomLeft: Radius.circular(context.locale.toString() == 'ar'?0:10.r),
                                    topRight: Radius.circular(context.locale.toString() == 'en'?0:10.r),
                                    bottomRight: Radius.circular(context.locale.toString() == 'en'?0:10.r)
                                )                          ),
                            child: Center(
                              child: Text(
                               '${LocaleKeys.New.tr()} (${context.read<OrderCubit>().newTotal.toString()})',
                                style: TextStyle(
                                  color:  OrderCubit.selectedIndex  == 0 ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              OrderCubit.selectedIndex  = 1;
                              context.read<OrderCubit>().page = 1;
            context.read<OrderCubit>().openOrderOnLoad();
            OrderCubit.categoryNum = 2;
                            });
                          },
                          child: Container(
                            color:  OrderCubit.selectedIndex  == 1 ?  AppTheme.kPrimary : Colors.transparent,
                            child: Center(
                              child: Text(
                                '${LocaleKeys.open.tr()} (${context.read<OrderCubit>().openTotal.toString()})',

                                style: TextStyle(
                                  color:  OrderCubit.selectedIndex  == 1 ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              OrderCubit.selectedIndex  = 2;
                              context.read<OrderCubit>().page = 1;
            context.read<OrderCubit>().closedOrderOnLoad();
            OrderCubit.categoryNum = 3;
                            });
                          },
                          child: Container(
                           // color: _selectedIndex == 2 ? const Color(0xFF00BAAB) : Colors.transparent,
                            decoration: BoxDecoration(
                                color:  OrderCubit.selectedIndex  == 2 ?   AppTheme.kPrimary: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(context.locale.toString() == 'en'?0:10.r),
                                    bottomLeft: Radius.circular(context.locale.toString() == 'en'?0:10.r),
                                    topRight: Radius.circular(context.locale.toString() == 'ar'?0:10.r),
                                    bottomRight: Radius.circular(context.locale.toString() == 'ar'?0:10.r)
                                )                          ),
                            child: Center(
                              child: Text(
                                  '${LocaleKeys.history.tr()} (${context.read<OrderCubit>().historyTotal.toString()})',

                                style: TextStyle(
                                  color:  OrderCubit.selectedIndex  == 2 ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                orders.isEmpty?

                Column(
                  children: [
                    SizedBox(
                      height: size.height * .12,
                    ),
                    Center(
                      child: lottie.Lottie.asset( "assets/images/empty.json"
                          ,height: size.height * .3,fit: BoxFit.fill),
                    ),
                  ],
                )
                    : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: orders.length,
                      itemBuilder: (ctx, index) => OrderItem(
                          orders: orders[index],
                          acceptOrder: () {
                            ordersState.acceptOrder(orders[index].id!, context);
                            setState(() {
                              OrderCubit.selectedIndex = 1;
                            });
                          },
                        rejectOrder: () {
                          ordersState.rejectOrder(orders[index].id!, context);
        
                        },
                        deliverOrder:  () {
                          ordersState.deliverOrder(orders[index].id!, context);
                          setState(() {
                            OrderCubit.selectedIndex = 0;
                          });
                        },
                        failedOrder:  () {
                          ordersState.failedOrder(orders[index].id!, context);
                          setState(() {
                            OrderCubit.selectedIndex = 0;
                          });
                        },
                        orderState: ordersState,
        
                      )) ],)
            ),
          ),
        );
        }),
      ),
    );
  }

}
