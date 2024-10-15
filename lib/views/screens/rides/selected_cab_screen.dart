import 'package:albrandz_cbt_p/views/screens/card/add_card_screen.dart';
import 'package:albrandz_cbt_p/views/screens/home/drawer_screen.dart';
import 'package:albrandz_cbt_p/views/screens/profile/widgets/profile_view_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/rides/cab_selection_screen.dart';
import 'package:albrandz_cbt_p/views/screens/rides/ride_driver_details_screen.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/builders/date_time_builder.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/date_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SelectedCabScreen extends StatefulWidget {
  final CabSelectionModel cabData;
  const SelectedCabScreen({super.key, required this.cabData});

  @override
  State<SelectedCabScreen> createState() => _SelectedCabScreenState();
}

class _SelectedCabScreenState extends State<SelectedCabScreen> {
  var scheduleAt = "Expected drop off 02:00 PM";
  bool isScheduling = false;
  bool isShowingScheduleDialog = false;

  @override
  Widget build(BuildContext context) {
    var view = ProfileViewWidgets(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(widget.cabData.imagePath)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cabData.title,
                        style: AppTextStyle.boldBlack(),
                      ),
                      Text(
                        "\$ ${widget.cabData.fare}",
                        style: AppTextStyle.boldBlack(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cabData.time,
                        style: AppTextStyle.boldBlack(textSize: normalTextSize),
                      ),
                      Text(
                        widget.cabData.distance,
                        style: AppTextStyle.boldBlack(textSize: normalTextSize),
                      ),
                    ],
                  ),
                  Text(
                    widget.cabData.estimateTime,
                    style: AppTextStyle.normalBlack(textSize: semiBoldTextSize),
                  ),
                  Text(
                    scheduleAt,
                    style: AppTextStyle.normalBlack(textSize: semiBoldTextSize),
                  ),
                ],
              ),
            ),
            20.height,
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding + 5),
              color: fillInputColor,
              child: Row(
                children: [
                  AppImageView()
                      .assetSVGImageView(cashIcon, size: appIconSize - 5),
                  10.width,
                  Text(
                    CASH,
                    style: AppTextStyle.boldBlack(
                        textSize: normalTextSize,
                        color: semiBoldBlackTextColor),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
              height: 1,
            ),
            Container(
              padding: const EdgeInsets.only(left: horizontalPadding),
              color: const Color(0xffe8e7ec),
              child: view.infoFieldView(
                  title: ADD_CARD,
                  leadingIcon: creditCardIcon,
                  trailingButton: IconButton(
                      onPressed: () {
                        context.toNext(AddCardScreen());
                      },
                      icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add),
                      ))),
            ),
            bottomView(context),
          ],
        ),
      ),
    );
  }

  Widget bottomView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: horizontalPadding,
          left: horizontalPadding,
          bottom: horizontalPadding),
      child: Row(
        children: [
          Expanded(
              child: ButtonWidgets().appButtonFillView(isScheduling?SCHEDULE:BOOK_NOW, onTap: () {
                if(isScheduling){
                  showScheduleDialog();
                  setState(() {
                    isShowingScheduleDialog = true;
                  });
                }else{
                  showCabSearchingDialog(context);
                }

          })),
          IconButton(
              onPressed: () async{
                var date = await DateTimeBuilder(context: context)
                    .showDateTimePickerView(
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 60)));
                scheduleAt = "Schedule At ${date?.fullDateAndTime}";
                setState(() {
                  isScheduling = true;
                });
              },
              icon: AppImageView().assetSVGImageView(expiryDateIcon, size: 60))
        ],
      ),
    );
  }

  showCabSearchingDialog(BuildContext context) {
    var height = context.fullHeight;
    Future.delayed(const Duration(seconds: 3), () {
      AppDialogHelper.showCustomBottomSheet(context,
          child: const RideDriverDetailsScreen(), height: height / 1.7);
    });
    return AppDialogHelper.showCustomBottomSheet(context,
        child: Column(
          children: [
            20.height,
            LinearProgressIndicator(
                backgroundColor: fillInputColor, color: primaryColor),
            Padding(
              padding:
                  const EdgeInsets.all(horizontalPadding + horizontalPadding),
              child: Image.asset(
                searchCabImagePath,
                height: height / 7,
              ),
            )
          ],
        ),
        height: height / 3.5);
  }

  showScheduleDialog(){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (value,d){
            if(isShowingScheduleDialog){
              context.toNextRemove(DrawerScreen());
            }else{
              context.onBackPressed;
            }
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.all()),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // context.onBackPressed;
                    context.toNextRemove(const DrawerScreen());
                  },
                  child: Text(
                    OK,
                    style:  AppTextStyle.semiBoldWhite(),
                  ))
            ],
            title:  Text("Successfully Schedule",style: AppTextStyle.boldBlack(),),
            content: SizedBox(
              height: context.fullHeight/7,
              child: Column(
                children: [
                  Lottie.asset(successAnimationPath,height: 100,width: 100,fit: BoxFit.cover),
                  Text(scheduleAt)
                ],
              ),
            ),
          ),
        ));
  }
}
