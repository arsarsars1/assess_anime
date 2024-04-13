import 'package:assess_anime/controller/main_controller.dart';
import 'package:assess_anime/screen/create_character/create_character.dart';
import 'package:assess_anime/screen/main_page/widget/main_widget.dart';
import 'package:assess_anime/services/navigation_service.dart';
import 'package:assess_anime/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: MainController(),
          builder: (controller) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(
                      3,
                      (index) => MainWidget(
                        index: index + 1,
                        controller: controller,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          if (controller.selectedItem.isNotEmpty) {
                            NavigationService.pushRoute(const CreateCharacter(),
                                fullscreenDialog: true);
                          }
                        },
                        title: "Start",
                        isSelected: controller.selectedItem.isNotEmpty,
                      ),
                    ),
                  ]),
                ]);
          }),
    );
  }
}
