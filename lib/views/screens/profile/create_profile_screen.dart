import 'package:albrandz_cbt_p/controllers/auth/auth_controller.dart';
import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/controllers/profile/profile_controller.dart';
import 'package:albrandz_cbt_p/models/profile/create_profile_model.dart';
import 'package:albrandz_cbt_p/views/screens/login/login_widgets.dart';
import 'package:albrandz_cbt_p/views/screens/profile/widgets/profile_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/builders/app_country_code_builder.dart';
import 'package:albrandz_cbt_p/views/utils/builders/loader_builder.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/date_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/string_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/constants.dart';
import '../../utils/widgets/button_widgets.dart';
import '../home/landing_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  var createKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  String selectedGender = "";
  var profileController = Get.put(ProfileController());
  final _authController = Get.put(AuthController());
  var initCountry = CountryData();
  @override
  void initState() {
    super.initState();
   // init();
  }

  init() {
    setState(() {
      mobileController =
          TextEditingController(text: _authController.mobileNumber.value);
      initCountry = CountryData(
          code: _authController.countryCode.value,
          flag: _authController.countryFlag.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var view = ProfileWidgets(context: context);
    var height = context.fullHeight;
    var width = context.fullWidth;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              AppImageView.screenBackgroundImageView(path: createProfileImagePath, size: Size(width, height * .25)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
                child: Form(
                  key: createKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      view.titleView(CREATE_PROFILE),
                      20.height,
                      view.fieldTitleTextView(
                        FULL_NAME_TITLE,
                      ),
                      5.height,
                      view.textFieldView(nameController,
                          keyBoard: TextInputType.text,
                          icon: profileNameIcon,
                          validator: (text) =>
                          text!.isEmpty ? "This field is required" : null),
                      16.height,
                      view.fieldTitleTextView(MOBILE_TITLE),
                      5.height,
                      view.mobileWithCountryCod4Field(mobileController,
                          country: initCountry),
                      16.height,
                      view.fieldTitleTextView(EMAIL_ID_TITLE),
                      5.height,
                      view.textFieldView(emailController, icon: emailIdIcon),
                      16.height,
                      SizedBox(
                        height: 95,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  view.fieldTitleTextView(DATE_OF_BIRTH_TITLE),
                                  5.height,
                                  view.textFieldView(
                                    dobController,
                                    onTap: () {
                                      showCalenderView();
                                    },
                                    validator: (text)=> text?.defaultValidator(),
                                    icon: dobIcon,
                                    onlyRead: true,
                                    keyBoard: TextInputType.datetime,
                                  )
                                ],
                              ),
                            ),
                            10.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  view.fieldTitleTextView(GENDER_TITLE),
                                  5.height,
                                  view.appDropDownView(
                                      ["Male", "Female", "Other"],
                                      onChanged: (text) {
                                        setState(() {
                                          selectedGender = text;
                                        });
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      view.fieldTitleTextView(PIN_TITLE),
                      5.height,
                      LoginWidgets(context: context)
                          .pinTextFieldView(pinController, icon: Icons.lock_outlined),
                      20.height,
                      view.policyCheckboxView(
                          onChanged: onCheckBoxChanged, value: isChecked),
                      30.height,
                      ButtonWidgets().appButtonFillView(CONTINUE, onTap: () {
                        _validField();
                      }, width: width),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  bool isChecked = false;

  void onCheckBoxChanged(bool? value) {
    setState(() {
      isChecked = !isChecked;
    });
  }

  _validField() {
    if (createKey.currentState!.validate()) {
      if (!isChecked) {
        Get.snackbar("Warning!", "Please check terms & policy");
      } else {
        createNewUser();
      }
    }
  }

  var dob = DateTime.now();

  showCalenderView() async {
    dob = (await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime.now()))!;
    setState(() {});
    dobController = TextEditingController(text: dob.toDateOnly);
  }

  createNewUser() async {
    var data = CreateProfileModel(
        dob: dob.toDateOnly,
        email: emailController.text.trim(),
        gender: selectedGender,
        name: nameController.text.trim(),
        pin: pinController.text.trim());
    LoaderBuilder(context: context).showFullScreenLoader();
    await profileController.createProfile(data);
    LoaderBuilder(context: context).dismissLoader();
    if (profileController.isProfileCreated.value) {
      UserLocalDataController().storeLogInStatus();
      context.toNextRemove( LandingScreen());
    }
  }
}
