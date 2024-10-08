import 'package:albrandz_cbt_p/views/screens/rides/selected_cab_screen.dart';
import 'package:albrandz_cbt_p/views/screens/rides/widgets/cab_selection_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:flutter/material.dart';

class CabSelectionScreen extends StatefulWidget {
  const CabSelectionScreen({super.key});

  @override
  State<CabSelectionScreen> createState() => _CabSelectionScreenState();
}

class _CabSelectionScreenState extends State<CabSelectionScreen> {
  var selectedItem = -1;
  bool isCabSelected = false;
  @override
  Widget build(BuildContext context) {
    var view = CabSelectionWidgets(context: context);
    var height = context.fullHeight;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return InkWell(
                      borderRadius:
                          AppBorderRadius.all(radius: sheetBorderRadiusSize/2),
                      onTap: () {
                        setState(() {
                          selectedItem = index;
                          isCabSelected = true;
                        });
                      },
                      child: view.cabItemView(
                          selectedItem == index ? true : false,
                          CabSelectionModel.cars()[index]));
                },
                separatorBuilder: (_, index) {
                  return const Divider(
                    thickness: defaultBorderWidth,
                    indent: 30,
                    endIndent: 30,
                  );
                },
                itemCount: CabSelectionModel.cars().length),
          ),
          10.height,
          view.bottomView(isCabSelected, onPressed: () {
            AppDialogHelper.showCustomBottomSheet(context,
                child: SelectedCabScreen(
                    cabData: CabSelectionModel.cars()[selectedItem]),
                height: height / 2);
          }),
          16.height
        ],
      ),
    );
  }
}

class CabSelectionModel {
  String imagePath;
  String title;
  String estimateTime;
  String time;
  String fare;
  String distance;

  CabSelectionModel(
      {required this.title,
      required this.imagePath,
      required this.estimateTime,
      required this.fare,
      required this.time,
      required this.distance});

  static List<CabSelectionModel> cars() => [
        CabSelectionModel(
            title: "One",
            imagePath: oneCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Two",
            imagePath: twoCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Three",
            imagePath: threeCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Four",
            imagePath: fourCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Five",
            imagePath: fiveCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Six",
            imagePath: sixCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Seven",
            imagePath: sevenCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
        CabSelectionModel(
            title: "Eight",
            imagePath: eightCarImagePath,
            estimateTime: "In just 8 min.",
            fare: "20.25",
            time: "10:20 AM",
            distance: "15 Kms"),
      ];
}
