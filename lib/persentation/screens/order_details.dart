import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/order_details_bloc/order_details_cubit.dart';
import '../../data/models/order_details_model.dart';
import '../../data/models/order_model.dart';
import '../../styles.dart';
import '../../theme.dart';
import '../../translations/locale_keys.g.dart';
import '../wedgits/delivery_address.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Client client;
  const OrderDetailsScreen({Key? key, required this.client,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<int> list =[];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Column(
            children: [
              BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                  builder: (context, state) {

                    if (state is OrderDetailsLoading) {
                      return Center(
                        child: Container(
                          height: size.height ,
                          width: size.width * 0.5,
                          alignment: Alignment.bottomCenter,
                          child:Center(
                            child: LoadingAnimationWidget.fallingDot(
                              size: 70.h,
                              color: AppTheme.kPrimary,
                            ),
                          )
                        ),
                      );
                    }

                    if(state is OrderDetailsLoaded){
                      OrderDetailsModel order = state.order;
                      return Column(
                        children: [
                          SizedBox(
                            height: size.height * .01,
                          ),


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              //    mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 28,
                                      color: AppTheme.kPrimary,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Text(
                                  order.orderNo,
                                  style: TextStyle(fontSize: size.width *.07, fontWeight: FontWeight.bold,color:  AppTheme.nearlyBlack,),
                                ),
                                // SizedBox(width: 60,),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * .01,),
                          Container(
                            margin: EdgeInsets.only(top: 24.h,left: 16.w,right: 16.w),
                            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.kLightGrey),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    if(order.branch.company.image!= null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          order. branch.company.image.toString()??'',
                                          height: 55.h,
                                          //  width: 100.0,
                                        ),
                                      ),
                                    SizedBox(width: 10.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.branch.updatedAt != null && order.branch.updatedAt.isNotEmpty
                                              ? order.branch.updatedAt
                                              : order.branch.createdAt,
                                          style: Styles.kBold14,
                                        ),
                                        Text("${LocaleKeys.delivered_by.tr()}:", style: Styles.kBold14),
                                        Text(order.branch.title.lang.toString(), style: Styles.kBold14),
                                        InkWell(
                                          onTap: () async {
                                            String googleUrl =
                                                'https://www.google.com/maps/search/?api=1&query=${order.branch.lat},${order.branch.lng}';
                                            await launch(googleUrl);
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/location2.svg',
                                                color: AppTheme.kPrimary,
                                                height: .025.sh,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(order.branch.address.lang.toString(), style: Styles.kBold14),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * .02,),
                          DeliveryAddress(address: order.address,client: client,),
                          SizedBox(height: size.height * .02,),

                          Container(
                            width: size.width *.9,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:order.details.length,
                                itemBuilder: (ctx, index) {
                                  Product product = order.details[index].product!;
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Padding(
                                      padding:  EdgeInsets.only(
                                          top: 6, left: 16, right: 16, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                flex:2,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(7),
                                                  child: SimpleShadow(
                                                      opacity: 0.3, // Default: 0.5
                                                      color: Colors.black, // Default: Black
                                                      offset: Offset(1, 3), // Default: Offset(2, 2)
                                                      sigma: 5, // Defaul
                                                      child: Image.network(product.images[0].image)),

                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:size.width *.4,
                                                      child: Text(product.title!.lang!,  overflow: TextOverflow.ellipsis, maxLines: 1,
                                                        softWrap: false,style: TextStyle( fontSize: size.width * .04,fontWeight: FontWeight.bold,height: size.height * .003),),
                                                    ),
                                                    // SizedBox(height: 5,),
                                                    Text('${LocaleKeys.quantity.tr()} / ${order.details![index].quantity}',style: TextStyle( fontSize:  size.width * .035,height: size.height * .002),),
                                                    SizedBox(height: size.height * .005,),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,

                            child: Container(
                              margin: EdgeInsets.only(top: 0.h,left: 16.w,right: 16.w),
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.kLightGrey),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  Text(LocaleKeys.the_total_amount.tr(),
                                    style: TextStyle(fontSize:  size.width * .05,fontWeight: FontWeight.bold,height: size.height * .002,),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text( LocaleKeys.payment_method.tr(),
                                        style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                                        child: Text(order.paymentMethod!.title!.lang.toString(), style:  TextStyle(fontSize:  size.width * .04, color:order.paymentMethodId ==1?Colors.red: Colors.green,height: size.height * .0015,)),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text( LocaleKeys.sub_total.tr(),
                                        style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                                        child: Text(order.subtotal.toStringAsFixed(2)+ ' ${LocaleKeys.kwd.tr()}', style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,)),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text( LocaleKeys.tax_expense.tr(),
                                        style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                                        child: Text(order.tax!.toStringAsFixed(2)+ ' ${LocaleKeys.kwd.tr()}', style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,)),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  if(order.deliveryFee !=0)
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text( LocaleKeys.delivery.tr(),
                                          style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,),
                                          textAlign: TextAlign.center,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                                          child: Text(order.deliveryFee!.toStringAsFixed(2)+ ' ${LocaleKeys.kwd.tr()}', style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,)),
                                        ),

                                      ],
                                    ),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text( LocaleKeys.total_order.tr(),
                                        style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                                        child: Text(order.total.toStringAsFixed(2)+ ' ${LocaleKeys.kwd.tr()}', style:  TextStyle(fontSize:  size.width * .04, color: Colors.black,height: size.height * .0015,fontWeight: FontWeight.bold)),
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: size.height * .03,
                                  ),
                                  // SizedBox(
                                  //   height: size.height * .12,
                                  // ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      );
                    }
                    return SizedBox();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
