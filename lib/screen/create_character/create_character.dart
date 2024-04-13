import 'package:assess_anime/controller/charcter_controller.dart';
import 'package:assess_anime/core/colors/colors.dart';
import 'package:assess_anime/services/navigation_service.dart';
import 'package:assess_anime/widgets/custom_button.dart';
import 'package:assess_anime/widgets/field_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCharacter extends StatefulWidget {
  const CreateCharacter({super.key});

  @override
  State<CreateCharacter> createState() => _CreateCharacterState();
}

class _CreateCharacterState extends State<CreateCharacter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: GetX(
          init: CharacterController(),
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                leading: const CloseButton(
                  color: Colors.white,
                ),
                backgroundColor: Colors.black,
                title: const Text(
                  "Create Character",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(shrinkWrap: true, children: [
                        FieldInput(
                          onTap: () => setState(() {}),
                          controller: controller.name,
                          title: "Name",
                        ),
                        FieldInput(
                          onTap: () => setState(() {}),
                          controller: controller.intro,
                          title: "Intro",
                          maxLine: 3,
                        ),
                        FieldInput(
                          onTap: () => setState(() {}),
                          controller: controller.description,
                          title: "Description",
                          maxLine: 3,
                        ),
                        FieldInput(
                          onTap: () => setState(() {}),
                          controller: controller.firstMsg,
                          title: "First Message",
                          maxLine: 3,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                      ]),
              ),
              bottomNavigationBar: Row(children: [
                Expanded(
                  flex: 3,
                  child: TextButton(
                      onPressed: () {
                        NavigationService.pop();
                      },
                      child: Text(
                        "Back",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: CustomColors.primary,
                                ),
                      )),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: CustomButton(
                    onTap: () {
                      setState(() {});
                      if (controller.isField) {
                        controller.createCharacter(context);
                        // NavigationService.pushRoute(const CreateCharacter(),
                        //     fullscreenDialog: true);
                      }
                    },
                    title: "Next",
                    isSelected: controller.isField,
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
