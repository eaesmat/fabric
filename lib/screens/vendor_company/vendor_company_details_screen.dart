import 'package:fabricproject/screens/draw/draw_calculation_screen.dart';
import 'package:fabricproject/screens/draw/draw_list_screen.dart';
import 'package:fabricproject/screens/fabric_purchase/fabric_purchase_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class VendorCompanyDetailsListScreen extends StatefulWidget {
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
  int _selectedIndex = 0; // Track the selected tab index

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
                  _buildTab(Icons.list_alt_outlined,'fabrics' , 0),
                  _buildTab(Icons.draw, 'draw',1),
                  _buildTab(Icons.account_balance_wallet, 'transaction', 2),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FabricPurchaseListScreen(
              vendorCompanyId: widget.vendorCompanyId,
              vendorCompanyName: widget.vendorCompanyName,
            ),
            DrawListScreen(
              vendorCompanyId: widget.vendorCompanyId,
              vendorCompanyName: widget.vendorCompanyName,
            ),
            const DrawCalculation(),
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
          SizedBox(width: 8), // Adjust spacing between icon and text
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
