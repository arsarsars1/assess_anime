import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedItem = "".obs;

  void select(String select) {
    selectedItem(select);
  }

  bool isSame(int index) => selectedItem.value == index.toString();
}
