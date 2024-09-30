import 'package:albrandz_cbt_p/views/screens/home/widgets/home_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeScreen extends StatelessWidget {
  final AdvancedDrawerController controller;
    HomeScreen({super.key, required this.controller});

   var banners = [
     banner1Path,
     banner2Path,
     banner3Path
   ];

  var suggestions = [
    {
      "title":"Ride",
      "image":rideCarImagePath
    },
    {
      "title":"Rental",
      "image":rentalCarImagePath
    },{
      "title":"Reserve",
      "image":calenderIcon
    }
  ];

  @override
  Widget build(BuildContext context) {
    var height = context.fullHeight;
    var width = context.fullWidth;
    var view = HomeWidgets(context: context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.grey,
        title: const Text.rich(
          TextSpan(
            text: ' Good Afternoon,\n ',
            // style: GoogleFonts.nunitoSans(
            //   textStyle: TextStyle(
            //     color: Colors.white,
            //     fontSize: 17,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            children: <TextSpan>[
              TextSpan(text: ''),
              TextSpan(
                text: 'Abdul Hasan',
                // style: GoogleFonts.nunitoSans(
                //   textStyle: TextStyle(
                //       color: Colors.white,
                //       fontSize: 19,
                //       fontWeight: FontWeight.w700),
                // ),
                // recognizer: TapGestureRecognizer()
                //   ..onTap = () {},
              ),
            ],
          ),
        ),
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                iconSize: 20,
                onPressed: controller.showDrawer,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: controller,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppImageView.screenBackgroundImageView(path: homeImagePath, size: Size(width, height*.30)),
            Padding(padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                view.searchView(),
                view.drawerListItemView(title: "Recents", prefixIcon: Icons.calendar_month,color: semiBoldBlackTextColor),
                view.drawerListItemView(title: SAVE_PLACES, prefixIcon: Icons.star_border,color: semiBoldBlackTextColor),
                10.height,
                view.suggestionTitleView(),
                SizedBox(
                  height: 120,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: suggestions.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (_,index){
                    return view.suggestionItemView(title: suggestions[index]['title'].toString(), imagePath: suggestions[index]['image'].toString());

                  }),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: banners.length,
                      itemBuilder: (_,index){
                    return Image.asset(banners[index]);
                  }, separatorBuilder: (BuildContext context, int index) {
                      return 10.width;
                  },),
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }
}



// import 'package:albrandz_cbt_p/views/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _advancedDrawerController = AdvancedDrawerController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       backdrop: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             stops: [1,2],
//             colors: [primaryColor, Colors.white.withOpacity(1)],
//           ),
//         ),
//       ),
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       // openScale: 1.0,
//       disabledGestures: false,
//       childDecoration: const BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Advanced Drawer Example'),
//           leading: IconButton(
//             onPressed: _handleMenuButtonPressed,
//             icon: ValueListenableBuilder<AdvancedDrawerValue>(
//               valueListenable: _advancedDrawerController,
//               builder: (_, value, __) {
//                 return AnimatedSwitcher(
//                   duration: Duration(milliseconds: 250),
//                   child: Icon(
//                     value.visible ? Icons.clear : Icons.menu,
//                     key: ValueKey<bool>(value.visible),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         body: Container(),
//       ),
//       drawer: SafeArea(
//         child: Container(
//           child: ListTileTheme(
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Container(
//                   width: 128.0,
//                   height: 128.0,
//                   margin: const EdgeInsets.only(
//                     top: 24.0,
//                     bottom: 64.0,
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: Colors.black26,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.asset(
//                     'assets/images/flutter_logo.png',
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.home),
//                   title: Text('Home'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.account_circle_rounded),
//                   title: Text('Profile'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.favorite),
//                   title: Text('Favourites'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.settings),
//                   title: Text('Settings'),
//                 ),
//                 Spacer(),
//                 DefaultTextStyle(
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white54,
//                   ),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 16.0,
//                     ),
//                     child: Text('Terms of Service | Privacy Policy'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _handleMenuButtonPressed() {
//     // NOTICE: Manage Advanced Drawer state through the Controller.
//     // _advancedDrawerController.value = AdvancedDrawerValue.visible();
//     _advancedDrawerController.showDrawer();
//   }
// }