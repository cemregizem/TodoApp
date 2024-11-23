import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/controller/auth/auth_controller.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          AuthController.instance.logOut();
        },
      ),
      title: const Text('Plantist'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
