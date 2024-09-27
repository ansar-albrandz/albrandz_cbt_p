import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageBuilder{

  networkImageView(String imageUrl){
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(Icons.broken_image_outlined),
    );
  }

  assetCachedImage({required BuildContext context,required List<String> imagePaths})async{
    var _images = [];
    _images.addAll(imagePaths);
    _images.map((image) => precacheImage(AssetImage(image), context));
  }

}