
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  String? routeName;
  AppBarWidget({super.key,this.routeName});

  @override
  Widget build(BuildContext context) {
    final routeNameTitle =routeName != null ?routeName:GoRouter.of(context).location.split('/').last;
    return AppBar(title: Text(routeNameTitle!),leading: buildGoBackIconButton(context),);
  }
}

Widget buildGoBackIconButton(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed('home');
        // Or alternatively, allow the user to navigate back to onboarding with:
        //  context.push(Routes.dashboard);
      }
    },
  );
}