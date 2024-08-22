// ignore_for_file: file_names

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class FilePickerController extends GetxController {
  Rx<PlatformFile> fileImageData = PlatformFile(name: 'nothing', size: 0).obs;
  Rx<PlatformFile> fileProfileImageData = PlatformFile(name: 'nothing', size: 0).obs;
  Rx<PlatformFile> filePodcastImageData = PlatformFile(name: 'nothing', size: 0).obs;
  Rx<PlatformFile> fileAudioData = PlatformFile(name: 'nothing', size: 0).obs;
}
