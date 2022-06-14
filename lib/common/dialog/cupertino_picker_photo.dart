import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path/path.dart' as path;
import 'package:heic_to_jpg/heic_to_jpg.dart';

import '../localization/lang.dart';
import '../theme/theme.dart';
import '../widget/my_text_view.dart';

@immutable
class CupertinoPickerPhotoView extends StatelessWidget {
  final Function(String path) onSelectPhoto;
  final Function(List<String> path)? onSelectPhotos;
   ImagePicker imagePicker;
  CupertinoPickerPhotoView(
      {Key? key, required this.onSelectPhoto, this.onSelectPhotos,required this.imagePicker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              getCameraPhoto(context);
            },
            child: MyTextView(
              text: Lang.community_post_photo_post_camera.tr(),
              textStyle: textSmallxx.copyWith(
                  color: const Color(0xff212237),
                  fontFamily: MyFontFamily.graphik,
                  fontWeight: MyFontWeight.regular),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              if (onSelectPhotos != null) {
                getGalleryPhotos(context);
              } else {
                getGalleryPhoto(context);
              }
            },
            child: MyTextView(
              text: Lang.community_post_photo_post_photo_library.tr(),
              textStyle: textSmallxx.copyWith(
                  color: const Color(0xff212237),
                  fontFamily: MyFontFamily.graphik,
                  fontWeight: MyFontWeight.regular),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: MyTextView(
            text: Lang.community_post_photo_post_cancel.tr(),
            textStyle: textSmallxx.copyWith(
                color: const Color(0xff212237),
                fontFamily: MyFontFamily.graphik,
                fontWeight: MyFontWeight.regular),
          ),
        ));
  }

  Future getGalleryPhotos(BuildContext context) async {
    Navigator.pop(context);
    List<XFile>? resultList = [];
    var error = 'No Error Dectected';

    // UIUtil.showToast(Lang.report_hold_on_to_select_multiple.tr());
    try {
      final ImagePicker _picker = ImagePicker();
      resultList = await _picker.pickMultiImage();
      // MultiImagePicker.pickImages(
      //   maxImages: 3,
      //   enableCamera: true,
      //   selectedAssets: [],
      //   cupertinoOptions: const CupertinoOptions(takePhotoIcon: 'tag'),
      //   materialOptions: const MaterialOptions(
      //     actionBarColor: '#abcdef',
      //     actionBarTitle: 'Hudayriyat Island',
      //     allViewTitle: 'All Photos',
      //     useDetailsView: false,
      //     selectCircleStrokeColor: '#000000',
      //   ),
      // );
    } on Exception catch (e) {
      error = e.toString();
    }

    final paths = <String>[];
    for (var i = 0; i < resultList!.length; i++) {
      var newFile = File(resultList[i].path);
      final hasFile = await newFile.exists();
      if (hasFile) {
        final dir = path.dirname(newFile.path);
        if (Platform.isAndroid) {
          print('dir ' + dir);
          final newPath = path.join(
              dir,
              dir.contains('.jpg')
                  ? '${DateTime.now().millisecondsSinceEpoch}.jpg'
                  : '${DateTime.now().millisecondsSinceEpoch}.png');
          newFile = await newFile.rename(newPath);
          paths.add(newFile.path);
        } else {
          var jpegPath = newFile.path;
          if (jpegPath.toLowerCase().contains('.heic')) {
            jpegPath = (await HeicToJpg.convert(newFile.path))!;
          }
          paths.add(jpegPath);
        }
      }
    }
    if (onSelectPhotos != null && paths.isNotEmpty) {
      onSelectPhotos!(paths);
    }
  }

  Future getGalleryPhoto(BuildContext context) async {
    Navigator.pop(context);

    // // ignore: deprecated_member_use
    final image = await imagePicker.pickImage(
        maxWidth: 1024, source: ImageSource.gallery);
    if (image != null && image.path != null) {
      final dir = path.dirname(image.path);
      final newPath =
          path.join(dir, '${DateTime.now().millisecondsSinceEpoch}.jpg');
      await image.saveTo(newPath);
      // image.renameSync(newPath);
      onSelectPhoto(newPath);
    }
  }

  Future getCameraPhoto(BuildContext context) async {
    Navigator.pop(context);
    final image =
        // ignore: deprecated_member_use
        await imagePicker.pickImage(maxWidth: 1024, source: ImageSource.camera);
    if (image != null && image.path != null) {
      final dir = path.dirname(image.path);
      final newPath =
          path.join(dir, '${DateTime.now().millisecondsSinceEpoch}.jpg');
      await image.saveTo(newPath);
      // image.renameSync(newPath);
      if (onSelectPhoto != null) {
        onSelectPhoto(newPath);
      } else {
        onSelectPhotos!([newPath]);
      }
    }
  }
}
class FlutterAbsolutePath {
  static const MethodChannel _channel =
  const MethodChannel('flutter_absolute_path');

  /// Gets absolute path of the file from android URI or iOS PHAsset identifier
  /// The return of this method can be used directly with flutter [File] class
  static Future<String?> getAbsolutePath(String uri) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'uri': uri,
    };
    final String? path = await _channel.invokeMethod('getAbsolutePath', params);
    return path;
  }
}