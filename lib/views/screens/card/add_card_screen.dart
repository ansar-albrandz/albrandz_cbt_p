import 'package:albrandz_cbt_p/views/screens/card/widgets/card_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatelessWidget {
   AddCardScreen({super.key});

  TextEditingController debitNoController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = context.fullHeight;
    var width = context.fullWidth;
    var view = CardWidgets(context: context);
    var cardKey = GlobalKey<FormState>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomWidgets.customAppBarView(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImageView.screenBackgroundImageView(path: addCardImagePath, size: Size(width, height*.25)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
              child: Form(
                key: cardKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    view.titleView(ADD_CARD),
                    20.height,
                    view.fieldTitleTextView(DEBIT_CREDIT_CARD_NO),
                    5.height,
                    view.textFieldView(debitNoController, icon: creditCardIcon,validator: (text)=>text?.defaultValidator()),
                    16.height,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              view.fieldTitleTextView(EXPIRY_DATE),
                              5.height,
                              view.textFieldView(expiryDateController, icon: expiryDateIcon,validator: (text)=>text?.defaultValidator()),
                            ],
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              view.fieldTitleTextView(CVV),
                              5.height,
                              view.textFieldView(cvvController, icon: cvvIcon,validator: (text)=>text?.defaultValidator()),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    view.fieldTitleTextView(COUNTRY),
                    5.height,
                    view.appDropDownView(countryGlobIcon, null, onChanged: (text){}),
                    16.height,
                    view.fieldTitleTextView(NAME_ON_CARD,isRequired: false),
                    5.height,
                    view.textFieldView(nameOnCardController, icon: profileNameIcon),
                    40.height,
                    ButtonWidgets().appButtonFillView("Save",width: width,onTap: (){
                      if(cardKey.currentState!.validate()){
                      }
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
