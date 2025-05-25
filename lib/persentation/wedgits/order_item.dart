import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../bloc/home_bloc/order_cubit.dart';
import '../../bloc/order_details_bloc/order_details_cubit.dart';
import '../../data/models/order_model.dart';
import '../../data/reposetories/Order_details_repo.dart';
import '../../local_storage.dart';
import '../../theme.dart';
import '../../translations/locale_keys.g.dart';
import '../screens/order_details.dart';
import 'default_button.dart';

class OrderItem extends StatelessWidget {
  final OrderData orders;
  final Function? acceptOrder;
  final Function? rejectOrder;
  final Function? deliverOrder;
  final Function? failedOrder;
  final OrderCubit? orderState;

  // final int bunNum;
  OrderItem(
      {Key? key,
      required this.orders,
      this.acceptOrder,
      this.rejectOrder,
      this.deliverOrder,
      this.failedOrder,
      this.orderState})
      : super(key: key);
  final formKey = GlobalKey<FormState>();
  String? reason;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<OrderDetailsCubit>(
                  create: (BuildContext context) =>
                      OrderDetailsCubit(OrderDetailsRepo(), orders.id),
                  child: OrderDetailsScreen(client: orders.client,)),

            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //  height:OrderCubit.categoryNum != 3? size.height * .37: size.height * .2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(1.1, 4.0),
                blurRadius: 8.0),
          ],

          borderRadius: BorderRadius.circular(10),
          //  border: Border.all(color: AppTheme.secondary)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  SizedBox(height: size.height * .01,),
            Container(
              // width: size.width * .15,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.width * .08,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:   orders.paymentMethodId != 1? Color(0xffEAFDEE) : Color(0xffFFEAEA),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Colors.white
                      //           .withOpacity(0.3),
                      //       offset: const Offset(1.1, 4.0),
                      //       blurRadius: 8.0),
                      // ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          orders.paymentMethodId == 1
                              ? "assets/images/mony.png"
                              :"assets/images/visa.png",
                          height: size.width * .06,
                         // color: AppTheme.kPrimary,
                        ),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        Text(orders.paymentMethod!.title!.lang.toString(),
                            style: TextStyle(
                              //  decoration: TextDecoration.underline,
                              // fontFamily: fontName,
                              fontWeight: FontWeight.bold,
                              //  height: 0,
                              fontSize: size.width * .035,
                              letterSpacing: 0.18,
                              color: AppTheme.darkerText,
                            )),

                      ],
                    ),
                  ),
                  if (OrderCubit.selectedIndex != 2)
                  InkWell(
                    onTap: () {
                      launch("tel://${orders.client!.phone}");
                    },
                    child: Container(
                      height: size.width * .08,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(.2),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: size.width * .05,
                            color: AppTheme.kPrimary,
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(LocaleKeys.call_Client.tr(),
                              style: TextStyle(
                                //  decoration: TextDecoration.underline,
                                // fontFamily: fontName,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                fontSize: size.width * .035,
                                letterSpacing: 0.18,
                                color: AppTheme.darkerText,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    String googleUrl =
                        'https://www.google.com/maps/search/?api=1&query=${orders.address!.lat},${orders.address!.lng}';
                    if (OrderCubit.selectedIndex != 2) {
                      await launch(googleUrl);
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: size.width * .15,
                        height: size.width * .15,
                        decoration: BoxDecoration(
                          color: AppTheme.kPrimary.withOpacity(.8),
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            size: size.width * .08,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "موقع العميل",
                        style: TextStyle(
                          fontSize: size.width * .03, // حجم الخط
                          color: Colors.grey, // لون النص
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * .04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${LocaleKeys.my_orders.tr()} ${orders.orderNo}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .045,
                                letterSpacing: 0.18,
                                color: AppTheme.darkerText,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              orders.updatedAt != null && orders.updatedAt.isNotEmpty
                                  ? orders.updatedAt
                                  : orders.createdAt,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * .04,
                                color: AppTheme.darkerText.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .005,
                    ),
                    Row(
                      children: [
                        Text(orders.branch.title.lang.toString(),
                            style: TextStyle(
                              height: size.height * .0015,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * .045,
                              letterSpacing: 0.18,
                              color: Colors.black,
                            )),
                        SizedBox(
                          width: size.width * .03,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: size.height * .006,
            ),
            // if(OrderCubit.categoryNum != 3)
            // Padding(
            //   padding: const EdgeInsets.only(left: 58.0),
            //   child: Divider(
            //     thickness: 1.1,
            //   ),
            // ),
            if (OrderCubit.selectedIndex != 2)
              SizedBox(
                height: size.height * .01,
              ),
            if (OrderCubit.selectedIndex != 2)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<OrderDetailsCubit>(
                            create: (BuildContext context) => OrderDetailsCubit(
                                OrderDetailsRepo(), orders.id!),
                            child: OrderDetailsScreen(client: orders.client,)),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 58.0),
                  child: Row(
                    children: [
                      Text(LocaleKeys.see_more.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // fontFamily: fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .045,
                            letterSpacing: 0.18,
                            height: size.height * .002,

                            color: AppTheme.kPrimary,
                          )),
                      LocalStorage.getData(key: "lang") == "ar"
                          ? Icon(
                              Icons.keyboard_arrow_left_outlined,
                              color: AppTheme.kPrimary,
                            )
                          : Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: AppTheme.kPrimary,
                            )
                    ],
                  ),
                ),
              ),
            if (OrderCubit.selectedIndex != 2)
              SizedBox(
                height: size.height * .01,
              ),
            if (OrderCubit.selectedIndex != 2)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Divider(
                  thickness: 1.1,
                ),
              ),
            if (OrderCubit.selectedIndex != 2)
              SizedBox(
                height: size.height * .01,
              ),
            if (OrderCubit.selectedIndex != 2)
              SizedBox(
                height: size.height * .07,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultButton(
                        width: size.width * .35,
                        textColor: Colors.white,
                        color: AppTheme.kPrimary,
                        title: OrderCubit.selectedIndex == 0
                            ? LocaleKeys.accept_translate.tr()
                            : LocaleKeys.success.tr(),
                        radius: 15,
                        function: () {
                          if (OrderCubit.selectedIndex == 0)
                            acceptOrder!();
                          else
                            deliverOrder!();
                        },
                        font: size.height * 0.022,
                      ),
                      DefaultButton(
                        width: size.width * .35,
                        textColor: Colors.red,
                        color: AppTheme.white,
                        title: OrderCubit.selectedIndex == 0
                            ? LocaleKeys.reject_translate.tr()
                            : LocaleKeys.failed.tr(),
                        borderColor: Colors.red,
                        radius: 10,
                        function: () {
                          if (OrderCubit.selectedIndex == 0)
                            _showDialog(context, LocaleKeys.reject_reason.tr(),
                                rejectOrder!);
                          //rejectOrder!();
                          else
                            _showDialog(context, LocaleKeys.failed_reason.tr(),
                                failedOrder!);
                          //   rateState.rateOrder(orderId!);
                        },
                        font: size.height * 0.022,
                      )
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: size.height * .01,
            ),
          ],
        ),
      ),
    );
  }

  Future _showDialog(context, String title, Function send) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var we = MediaQuery.of(context).size.width;
        var he = MediaQuery.of(context).size.height;

        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: he * .02,
                        ),
                        Text(
                          LocaleKeys.note.tr(),
                          style: TextStyle(
                            color: AppTheme.orange,
                            fontSize: we * .055,
                            height: he * .002,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            height: he * .002,
                            fontSize: we * .045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 10.0, left: 10.0),
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.Required.tr();
                                }
                                return null;
                              },
                              onSaved: (val) {
                                orderState!.reason = val!;
                              },
                              style: TextStyle(
                                  fontSize: 18.0,
                                  height:
                                      MediaQuery.of(context).size.height * .0025),
                              //  keyboardType: TextInputType.number,
                              maxLines: 4,
                              cursorColor: AppTheme.kPrimary,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                fillColor: Colors.white,
                                hintText: LocaleKeys.note.tr(),
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                        color: AppTheme.kPrimary, width: 2.0)),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: he * .03,
                        ),
                        DefaultButton(
                          width: MediaQuery.of(context).size.width * .6,
                          textColor: Colors.white,
                          color: AppTheme.kPrimary,
                          title: LocaleKeys.send.tr(),
                          // borderColor: Colors.red,
                          radius: 10,
                          function: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            formKey.currentState!.save();
                            send();
                            //   rateState.rateOrder(orderId!);
                          },
                          font: MediaQuery.of(context).size.height * 0.022,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
