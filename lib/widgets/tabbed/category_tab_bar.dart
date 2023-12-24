import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/controllers/home_controller.dart';
import 'package:timberr/models/category.dart';
import 'package:timberr/widgets/buttons/category_button.dart';

class CategoryTabBar extends StatelessWidget {
  CategoryTabBar({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: [
            for (int i = 0; i < categoryList.length; i++)
              CategoryButton(
                name: categoryList[i].name,
                iconPath: categoryList[i].iconPath,
                isSelected: (i == _controller.selectedCategory.value),
                onTap: () {
                  _controller.changeCategory(i);
                },
              )
          ],
        ),
      ),
    );
  }
}
