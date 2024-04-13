import 'package:assess_anime/controller/main_controller.dart';
import 'package:assess_anime/core/colors/colors.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  final int index;
  final MainController controller;
  const MainWidget({super.key, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            controller.selectedItem(index.toString());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: controller.isSame(index)
                    ? CustomColors.primary
                    : CustomColors.lightGrey,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/anime$index.jpg",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  index == 1
                      ? "Boy"
                      : index == 2
                          ? "Girl"
                          : "Non-Binary",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: controller.isSame(index)
                        ? CustomColors.primary
                        : CustomColors.lightGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
