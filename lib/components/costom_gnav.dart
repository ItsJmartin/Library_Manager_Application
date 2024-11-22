import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:library_management_app/book/book_provider.dart';
import 'package:provider/provider.dart';

class GNavigationBar extends StatelessWidget {
  const GNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex = Provider.of<BookProvider>(context).selectedTabIndex;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(
          color: Color(0xffffffff),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: GNav(
          gap: 5,
          activeColor: Color(0xffffffff),
          color: Colors.grey.shade700,
          padding: const EdgeInsets.all(16),
          selectedIndex: selectedTabIndex,
          onTabChange: (index) {
            Provider.of<BookProvider>(context, listen: false)
                .updateTabIndex(index);
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.favorite_border_outlined,
              text: "Favorite",
            ),
            GButton(
              icon: Icons.shopping_bag_outlined,
              text: "Bag",
            ),
            GButton(
              icon: Icons.settings,
              text: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
