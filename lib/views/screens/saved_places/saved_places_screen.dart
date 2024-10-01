import 'package:albrandz_cbt_p/views/screens/saved_places/saved_places_widget.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/double_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var view = SavedPlacesWidget(context: context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomWidgets.customAppBarView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
        
      },child: const Icon(Icons.add_home_outlined),),
      body: Container(
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(savedPlaceImagePath), fit: BoxFit.fill),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            view.titleView(),
            (screenSize.height*.10).height,
            Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Colors.white,
              child:  ListView.builder(
                itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return view.listItemView();
                  }),
            )

            // SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
