// ignore_for_file: file_names

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';

FilePickerController _filePickerController = Get.put(FilePickerController());
pickImagefile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (result != null) {
    _filePickerController.fileImageData.value = result.files.first;
  }
}

pickPodcastImagefile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (result != null) {
    _filePickerController.fileImageData.value = result.files.first;
  }
}

pickProfileImagefile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (result != null) {
    _filePickerController.fileProfileImageData.value = result.files.first;
  }
}

pickAudioFile() async {
  FilePickerResult? audioResult = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (audioResult != null) {
    _filePickerController.fileAudioData.value = audioResult.files.first;
  }
}
