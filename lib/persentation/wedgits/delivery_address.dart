import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/order_details_model.dart';
import '../../data/models/order_model.dart';
import '../../styles.dart';
import '../../theme.dart';
import '../../translations/locale_keys.g.dart';


class DeliveryAddress extends StatelessWidget {
  final OrderDetailsModelAddress address;
  final Client client;

  const DeliveryAddress({Key? key,  required this.address, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.kLightGrey),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${LocaleKeys.delivered_to.tr()} : ",
                style: Styles.kBold14.copyWith(color: AppTheme.grey),
              ),
              SizedBox(width: 4.h),
              Flexible(
                child: Text(
                  "${address?.city?.title.lang ?? ''}, ${address?.zone?.title.lang ?? ''}, ${address?.subZone?.title.lang ?? ''}",
                  style: Styles.kBold14,
                  overflow: TextOverflow.ellipsis, // قص النص إذا تجاوز العرض
                  maxLines: 2, // عدد الأسطر المسموح بها
                ),
              ),
            ],
          ),


          SizedBox(height: 9.h,),


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/location2.svg',color: AppTheme.kPrimary,height: .025.sh,),
              SizedBox(width: 12.w,),
              SizedBox(
                  width: .7.sw,
                  child: Text("${address?.street??''}, ${address?.block??
                      ''}, ${address?.houseNumber??''}", style: Styles.kMedium16,)),
            ],
          ),
          SizedBox(height: 5.h,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                address?.title == 'home'?
                'assets/images/home.svg':
                'assets/images/office.svg',color: AppTheme.kPrimary,height: .02.sh,),
              SizedBox(width: 12.w,),
              context.locale.toString() == 'ar'?
              SizedBox(
                  width: .7.sw,
                  child: Text(
                    address.title == 'home'?
                        'المنزل':"العمل"
                    , style: Styles.kMedium16,)):
              SizedBox(
                  width: .7.sw,
                  child: Text(

                    address?.title??'', style: Styles.kMedium16,)),
            ],
          ),
          SizedBox(height: 5.h,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/comment.svg',color: AppTheme.kPrimary,height: .02.sh,),
              SizedBox(width: 12.w,),
              SizedBox(
                  width: .7.sw,
                  child: Text(address?.notes??' ${LocaleKeys.not_found.tr()}', style: Styles.kMedium16,)),
            ],
          ),
          SizedBox(height: 5.h,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/user.svg',color: AppTheme.kPrimary,height: .02.sh,),
              SizedBox(width: 12.w,),
              SizedBox(
                  width: .7.sw,
                  child: Text(client.name, style: Styles.kMedium16,)),
            ],
          ),
          SizedBox(height: 5.h,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/phone.svg',color: AppTheme.kPrimary,height: .02.sh,),
              SizedBox(width: 12.w,),
              SizedBox(
                  width: .7.sw,
                  child: Text(client.phone, style: Styles.kMedium16,)),
            ],
          ),
        ],
      ),
    );
  }
}
