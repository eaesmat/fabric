import 'package:fabricproject/screens/customer_deal/customer_deal_list_screen.dart';
import 'package:fabricproject/screens/customer_payment%20copy/customer_deals_list_screen.dart';
import 'package:fabricproject/screens/customer_payment/customer_payment_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// this screen comes up on vendor company click
class CustomerDetailsScreen extends StatefulWidget {
  // gets the data from the controller
  final int customerId;
  final String customerName;
  const CustomerDetailsScreen({
    Key? key,
    required this.customerId,
    required this.customerName,
  }) : super(key: key);

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  // Track the selected tab index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextTitle(text: widget.customerName),
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
                  _buildTab(Icons.handshake, 'deals', 0),
                  _buildTab(Icons.shopify, 'sales', 1),
                  _buildTab(Icons.draw, 'receipts', 2),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // gets three screens in here
            const CustomerDealsListScreen(),
            CustomerDealListScreen(
              customerId: widget.customerId,
              customerName: widget.customerName,
            ),
            CustomerPaymentListScreen(
              customerId: widget.customerId,
              customerName: widget.customerName,
            )
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
