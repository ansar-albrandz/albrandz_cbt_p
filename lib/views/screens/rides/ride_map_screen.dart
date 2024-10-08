import 'package:albrandz_cbt_p/views/screens/rides/cab_selection_screen.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class RideMapScreen extends StatelessWidget {
  const RideMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonWidgets().appButtonFillView(NEXT,onTap: (){
             AppDialogHelper.showCustomBottomSheet(context,child: const CabSelectionScreen(),height: height/1.2);
            },width: width)
          ],
        ),
      ),
    );
  }
}
