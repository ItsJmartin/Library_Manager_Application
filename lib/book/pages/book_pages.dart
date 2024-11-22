import 'package:flutter/material.dart';
import 'package:library_management_app/book/book_provider.dart';
import 'package:library_management_app/book/pages/favorite_page.dart';
import 'package:library_management_app/book/pages/home.dart';
import 'package:library_management_app/components/add_item_popup.dart';
import 'package:library_management_app/components/costom_gnav.dart';
import 'package:library_management_app/components/custom_add_button.dart';
import 'package:provider/provider.dart';

class BookPages extends StatelessWidget {
  const BookPages({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex = Provider.of<BookProvider>(context).selectedTabIndex;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: selectedTabIndex,  // Changes the page based on selected tab index
        children: const [
          HomePage(),  // Home Page
          FavoritePage(),// Blank Favorite Page
          Scaffold(body: Center(child: Text("Bag Page"))),  // Blank Bag Page
          Scaffold(body: Center(child: Text("Settings Page"))),  // Blank Settings Page
        ],
      ),

       // custom action button
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => showAddBookDialog(context),
      ),
      bottomNavigationBar: const GNavigationBar(),
    );
  }
}
