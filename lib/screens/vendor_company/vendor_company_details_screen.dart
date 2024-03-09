import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// this screen comes up on vendor company click
class VendorCompanyDetailsListScreen extends StatefulWidget {
  // gets the data from the controller
  final int vendorCompanyId;
  final String vendorCompanyName;
  const VendorCompanyDetailsListScreen(
      {Key? key,
      required this.vendorCompanyId,
      required this.vendorCompanyName})
      : super(key: key);

  @override
  State<VendorCompanyDetailsListScreen> createState() =>
      _VendorCompanyDetailsListScreenState();
}

class _VendorCompanyDetailsListScreenState
    extends State<VendorCompanyDetailsListScreen> {
  // Track the selected tab index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextTitle(text: widget.vendorCompanyName),
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
                  _buildTab(Icons.list_alt_outlined, 'purchases', 0),
                  _buildTab(Icons.draw, 'receipts', 1),
                  _buildTab(Icons.account_balance_wallet, 'transactions', 2),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // gets three screens in here

            FabricPurchaseListScreen(
              vendorCompanyId: widget.vendorCompanyId,
              vendorCompanyName: widget.vendorCompanyName,
            ),
            // DrawListScreen(
            //   vendorCompanyId: widget.vendorCompanyId,
            //   vendorCompanyName: widget.vendorCompanyName,
            // ),
            // const DrawCalculation(),
             Container(),
             Container(),
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
