import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotosAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  const PhotosAppBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: TabBar(
        padding: EdgeInsets.only(top: 8, left: 16, right: 16),
        tabAlignment: TabAlignment.fill,
        isScrollable: false,

        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2.0,
        dividerHeight: 2.0,

        labelStyle: Theme.of(context).textTheme.labelLarge,
        unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
        unselectedLabelColor: Theme.of(context).colorScheme.secondary,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
