
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../persentation/wedgits/error_pop.dart';


class ServerConstants {
  static bool isValidResponse(int statusCode) {
    return statusCode >= 200 && statusCode <= 302;
  }

  static void showDialog1(BuildContext context, String s) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ErrorPopUp(message: '$s'),
    );
  }

static void snackBar ({
  required String msg,
  required BuildContext context,
}){
  showTopSnackBar(
      context as OverlayState,
      Card(
        child: CustomSnackBar.success(
          message: msg,
          backgroundColor: Colors.white,
          textStyle: TextStyle(
              color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.02),
        ),
      ));
}
  static void previewToast({
    required String msg,
    required BuildContext context,
    bool error = false,
    VoidCallback? onTap
  }) {

    showStyledToast(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Material(
          elevation: 20,
          child: InkWell(
            onTap: onTap,
            child: Container(
                width: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: error ? Colors.red[700] : Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!error)
                      Image.asset(
                        'assets/images/logo_pharmacy.png',
                        height: MediaQuery.of(context).size.height * 0.05
                      ),
                    if (error)
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 35,
                      ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(msg,
                          style: TextStyle(
                            fontSize: 18,
                              color: error ? Colors.white : Colors.black
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5),
                    ),
                  ],
                )),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      alignment: Alignment.topCenter,
      context: context,
    );

    // FancySnackbar.showSnackbar(
    //   context,
    //   snackBarType: FancySnackBarType.success,
    //   color:error? SnackBarColors.error3 : SnackBarColors.waitting5,
    //   title: description!=null? msg : error? 'error'.tr() : 'success'.tr(),
    //    message: description ?? msg,
    //   duration: 2,
    //   onCloseEvent: () {},
    // );
  }


  static const bool IS_DEBUG = true; // TODO: Close Debugging in Release.
  static const String API = "https://pharmacy.iconapp.site/api";
  // static const String API = "https://www.beta.toot.work/api";


  static const String login ='${API}/driver/auth/login';
  static const String availability ='${API}/driver/auth/availability';




  static const String logout ='${API}/driver/auth/logout';
  static const String unActive ='${API}/driver/auth/unActive';

  static const String statics ='${API}/driver/statics';
  static const String saveLocation ='${API}/driver/saveLocation';


  static const String lang ='${API}/driver/lang/change';

  static const String notification ='${API}/notification/all';
  static const String read ='${API}/notification/read';



  static const String changePassword = "${API}/driver/auth/changePassword";
  static const String details = "${API}/driver/order/details";


  static const String newOrders = "${API}/driver/orders/new";
  static const String openOrders = "${API}/driver/orders/open";
  static const String closedOrders = "${API}/driver/orders/closed";
  static const String acceptOrder = "${API}/driver/orders/accept";
  static const String rejectOrder = "${API}/driver/orders/refuse";
  static const String deliverOrder = "${API}/driver/orders/deliver";
  static const String failedOrder = "${API}/driver/orders/fail";






















}
