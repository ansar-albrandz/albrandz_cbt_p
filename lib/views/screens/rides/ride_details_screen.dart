import 'package:albrandz_cbt_p/views/screens/rides/cancel_ride_screen.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trip Details',
                  style: AppTextStyle.boldBlack(color: primaryColor),
                ),
              ],
            ),
            10.height,
            const Divider(),
            10.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  AppImageView().assetSVGImageView(startToEndThreeRideIcon,size: 40),
                  const SizedBox(width: 10),
                   Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(child: Text('Al Nahada  this is -1, Dubai, United Arab Emirates',style: AppTextStyle.normalBlack(textSize: semiBoldTextSize),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                            10.width,
                           Text("Change",style: AppTextStyle.normalBlack(),)
                         ],
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('Al Nahada -1, Dubai, United Arab Emirates',style: AppTextStyle.normalBlack(textSize: semiBoldTextSize,),maxLines: 2,overflow: TextOverflow.ellipsis)),
                            10.width,
                            Text("Change",style: AppTextStyle.normalBlack())
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            5.height,
            const Divider(indent: 35, endIndent: 35),
            5.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  AppImageView().assetSVGImageView(cashIcon,size: 20),
                  10.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$ 99.5",style: AppTextStyle.normalBlack(textSize: semiBoldTextSize),),
                        Text("Cash",style: AppTextStyle.normalBlack(textSize: semiBoldTextSize),),
                      ],
                    ),
                  ),
                  const Text("Switch")
                ],
              ),
            ),
            5.height,
            const Divider(indent: 35, endIndent: 35),
            5.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Share trip status',
                              style: AppTextStyle.normalBlack(textSize: semiBoldTextSize),
                            ),
                            Text(
                              'Share',
                              style: AppTextStyle.normalBlack(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ButtonWidgets().appButtonFillOutView(CANCEL_RIDE,width: width,onTap: (){
                AppDialogHelper.showCustomBottomSheet(context, child: CancelRideScreen(),height: height/2.4);
              }),
            ),
            10.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ButtonWidgets().appButtonFillOutView(DONE,width: width),
          ),
            20.height,
          ],
        ),
        // child: Column(
        //   children: [
        //     Text("Ride Details",style: AppTextStyle.boldBlack(color: primaryColor),),
        //     5.height,
        //     const Divider(thickness: defaultBorderWidth,height: 1,),
        //     Row(
        //       children: [
        //         AppImageView().assetSVGImageView(startToEndRideIcon,size: 35),
        //         Expanded(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Pick up point",style: AppTextStyle.semiBoldBlack(color: Colors.black,textSize: semiBoldTextSize),),
        //               Text("Change",style: AppTextStyle.normalBlack(),),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text("Pick up point",style: AppTextStyle.semiBoldBlack(color: Colors.black,textSize: semiBoldTextSize),),
        //         Text("Change",style: AppTextStyle.normalBlack(),),
        //       ],
        //     )
        //   ],
        // ),
      ),
    );
  }
}
