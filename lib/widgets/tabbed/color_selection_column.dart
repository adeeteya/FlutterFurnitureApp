import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/product_page_controller.dart';

class ColorSelectionColumn extends StatelessWidget {
  final List<Color> colorsList;
  final ProductPageController _controller = Get.find();
  ColorSelectionColumn({super.key, required this.colorsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Obx(
        () => Column(
          children: [
            for (int i = 0; i < colorsList.length; i++)
              GestureDetector(
                onTap: () {
                  _controller.colorIndex.value = i;
                },
                child: AnimatedContainer(
                  height: 34,
                  width: 34,
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: colorsList[i],
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: (_controller.colorIndex.value == i)
                          ? kTinGrey
                          : kSnowFlakeWhite,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
