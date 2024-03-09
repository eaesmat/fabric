import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_list_screen.dart';
import 'package:fabricproject/screens/khalid_rasid/khalid_rasid_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// this screen comes up on vendor company click
class KhalidDetailsScreen extends StatefulWidget {
  // gets the data from the controller

  const KhalidDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<KhalidDetailsScreen> createState() => _KhalidDetailsScreenState();
}

class _KhalidDetailsScreenState extends State<KhalidDetailsScreen> {
  // Track the selected tab index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleTexts(
            localeText: 'khalid_account',
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(30), // Adjust the height of the TabBar
            child: Container(
              color:
                  Theme.of(context).primaryColor, // Use AppBar's primary color
              child: TabBar(
                indicatorColor: Colors.transparent, // Hide the indicator
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index; // Update selected index
                  });
                },
                tabs: [
                  _buildTab(Icons.list_alt_sharp, 'purchases', 0),
                  _buildTab(Icons.draw, 'receipts', 1),
                  _buildTab(Icons.fact_check_sharp, 'withdrawal', 2),
                ],
              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
            // gets three screens in here

            const AllFabricPurchaseListScreen(),
            // DrawListScreen(
            //   vendorCompanyId: widget.vendorCompanyId,
            //   vendorCompanyName: widget.vendorCompanyName,
            // ),
            // KhalidDrawListScreen(),
            const KhalidRasidListScreen(),
            // Container(color: Colors.amber),
            Container(color: Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String text, int index) {
    return Tab(
      icon: Column(
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? Pallete.blueColor
                : Pallete.blackColor, // Change color based on selection
          ),
          const SizedBox(width: 8), // Adjust spacing between icon and text
          LocaleText(
            text,
            style: TextStyle(
              color: _selectedIndex == index
                  ? Pallete.blueColor
                  : Pallete.blackColor, // Change color based on selection
            ),
          ),
        ],
      ),
    );
  }
}
