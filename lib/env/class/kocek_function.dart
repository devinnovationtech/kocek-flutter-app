part of 'package:kocek_app/env/class/kocek_environment.dart';

class KocekFunction {
  static Future<XFile?> pickImage(BuildContext context,
      {ImageSource source = ImageSource.camera, int quality = 50}) async {
    try {
      if (source == ImageSource.gallery) {
        return ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: quality);
      } else {
        String? result = await CustomCameraDialog.onTap(context);
        if (result != null) {
          return XFile(result);
        } else {
          return null;
        }
      }
    } catch (e) {
      throw BugSheet(
              title: "Gagal Memuat Kamera",
              content: "$e",
              pagePath: "src/env/class/kocek_environment.dart",
              statePath: "")
          .openWith(context);
    }
  }

  static Future<void> pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        log("file: ${file.path}");
      } else {
        log("result: $result");
      }
    } catch (e) {
      throw BugSheet(
              title: "Gagal Memuat File",
              content: "$e",
              pagePath: "src/env/class/kocek_environment.dart",
              statePath: "")
          .openWith(context);
    }
  }

  static MultipartFile multipartFile(String path) {
    try {
      return MultipartFile.fromFileSync(path);
    } catch (e) {
      return MultipartFile.fromString("");
    }
  }
}
