import 'package:cred_stack/view/home_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      gotoHomeScreen();
    });
  }

  void gotoHomeScreen() {
    Get.off(
      HomeScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 1000),
    );
  }
}