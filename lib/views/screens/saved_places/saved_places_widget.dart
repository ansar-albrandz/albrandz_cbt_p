import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';
import '../../utils/styles/app_text_style.dart';

class SavedPlacesWidget {
  BuildContext context;
  SavedPlacesWidget({required this.context});
  Widget titleView() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.stars,
                size: 50,
              ),
              Text(
                SAVE_PLACES,
                style: AppTextStyle.boldBlack(),
              ),
            ],
          ),
        ),
  );

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
