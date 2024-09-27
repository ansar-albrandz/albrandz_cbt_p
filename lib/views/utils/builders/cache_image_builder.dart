import 'package:flutter/material.dart';

class CacheImageBuilder {
  BuildContext context;
  CacheImageBuilder({required this.context});

  initCacheImage(List<String> imagePaths)async{
    var _images = [];
    _images.addAll(imagePaths);
    _images.map((image) => precacheImage(AssetImage(image), context));
  }

}