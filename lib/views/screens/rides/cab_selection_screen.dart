import 'package:albrandz_cbt_p/views/screens/rides/widgets/cab_selection_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/builders/date_time_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
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

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        shrinkWrap: true,
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemBuilder: (_,index){
            return InkWell(
              borderRadius: AppBorderRadius.all(radius: sheetBorderRadiusSize),
              onTap: (){
                setState(() {
                  selectedItem = index;
                  isCabSelected = true;
                });
              },
                child: view.cabItemView(selectedItem == index?true:false,CabSelectionModel.cars()[index]));
          }, separatorBuilder: (_,index){
            return const Divider(thickness: defaultBorderWidth,indent: 30,endIndent: 30,);
          }, itemCount: CabSelectionModel.cars().length),
          view.bottomView(isCabSelected,onPressed: (){
            DateTimeBuilder(context: context).showDateTimePickerView(firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 60)));
          })
        ],
      ),
    );
  }
}

class CabSelectionModel{
  String imagePath;
  String title;
  String estimateTime;
  String time;
  String fare;

  CabSelectionModel({required this.title,required this.imagePath, required this.estimateTime, required this.fare, required this.time});

  static List<CabSelectionModel> cars() => [
    CabSelectionModel(title: "One", imagePath: oneCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Two", imagePath: twoCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Three", imagePath: threeCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Four", imagePath: fourCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Five", imagePath: fiveCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Six", imagePath: sixCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Seven", imagePath: sevenCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
    CabSelectionModel(title: "Eight", imagePath: eightCarImagePath, estimateTime: "In just 8 min.", fare: "20.25", time: "10:20 AM"),
  ];
}
