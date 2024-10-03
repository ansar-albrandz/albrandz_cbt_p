import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';

class SavedPlacesWidget {
  BuildContext context;
  SavedPlacesWidget({required this.context});

  Widget listItemView() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          leading: AppImageView().assetSVGImageView(homeIcon),
          title: Text("titile"),
          subtitle: Text("Subtitle"),
          trailing: AppImageView().assetSVGImageView(editProfileIcon),
        ),
        const Divider(thickness: defaultBorderWidth,endIndent: 35,indent: 35,)
      ],
    );
  }
}
