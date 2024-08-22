import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/themes/theme_text_style.dart';

class ThemeController extends GetxController {
  final GetStorage _box = GetStorage();
  final String _key = 'isDarkMode';

  RxBool isDarkMode = false.obs;

  ThemeController() {
    isDarkMode.value = _box.read(_key) ?? false;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _box.write(_key, isDarkMode.value);
    Get.changeTheme(isDarkMode.value ? DarkModeTheme.darkTheme : AppTheme.lightTheme);
  }
}
