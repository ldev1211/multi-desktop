import 'package:flutter/material.dart';
import 'package:multi_desktop/util/app_colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  AppAppBar({super.key, required this.title, this.actions = const []});

  List<Widget> actions = [];

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      actions: actions,
      elevation: 0,
      leadingWidth: 24,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.colorMain,
        ),
      ),
      centerTitle: false,
      title: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text(
          title,
          style: const TextStyle(
            color: AppColor.colorMain,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
