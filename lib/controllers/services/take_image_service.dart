/*
/// 1.add required dependency
  permission_handler: ^10.2.0
  image_picker: ^0.8.7+3

/// 2. add permission in the android manifest file
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

/// 3. add keys in the info.plist file (IOS)
<key>NSCameraUsageDescription</key>
<string>We need access to the camera for taking photos.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select images.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need permission to save images to your photo library.</string>
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class TakeImageService {
  final ImagePicker _picker = ImagePicker();

  // Request permission to access camera
  Future<bool> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  // Request permission to access gallery
  Future<bool> _requestGalleryPermission() async {
    PermissionStatus status = await Permission.storage.request();
    PermissionStatus photo = await Permission.photos.request();
    if (status == PermissionStatus.granted || photo == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  // Take image from camera
  Future<XFile?> takeImageFromCamera(BuildContext context) async {
    bool cameraPermissionGranted = await _requestCameraPermission();
    if (cameraPermissionGranted) {
      // final LostDataResponse response = await _picker.retrieveLostData();
      // if (response.isEmpty) {
      //   return null;
      // }
      return await _picker.pickImage(source: ImageSource.camera);
    } else {
      _showPermissionDeniedMessage(context, 'Camera');
      return null;
    }
  }

  // Take image from gallery
  Future<XFile?> takeImageFromGallery(BuildContext context) async {
    bool galleryPermissionGranted = await _requestGalleryPermission();

    if (galleryPermissionGranted) {
      return await _picker.pickImage(source: ImageSource.gallery);
    } else {
      _showPermissionDeniedMessage(context, 'Gallery');
      return null;
    }
  }

  // Helper to display permission denied message
  void _showPermissionDeniedMessage(
      BuildContext context, String permissionType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$permissionType permission denied'),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
