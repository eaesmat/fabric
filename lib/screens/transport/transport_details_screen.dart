import 'package:fabricproject/screens/transport/transport_calculation.dart';
import 'package:fabricproject/screens/transport_deals/transport_deals_list_screen.dart';
import 'package:fabricproject/screens/transport_payment/transport_payment_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
// this class uses tab bar to show three screens
class TransportDetailsScreen extends StatefulWidget {
  // gets this data from the controller class
  final int transportId;
  final String transportName;
  const TransportDetailsScreen({
    Key? key,
    required this.transportId,
    required this.transportName,
  }) : super(key: key);

  @override
  State<TransportDetailsScreen> createState() => _TransportDetailsScreenState();
}

class _TransportDetailsScreenState extends State<TransportDetailsScreen> {
  int _selectedIndex = 0; // Track the selected tab index

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextTitle(text: widget.transportName),
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
                  _buildTab(Icons.draw, 'payment', 1),
                  _buildTab(Icons.account_balance_wallet, 'transaction', 2),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TransportDealsListScreen(
              transportId: widget.transportId,
              transportName: widget.transportName,
            ),
            // const TransportPaymentListScreen(),
            // const TransportCalculation(),
             Container(color: Colors.green),
             Container(color: Colors.green),
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
          const SizedBox(width: 8),
          LocaleText(
            text,
            style: TextStyle(
               fontSize: 12,
              color: _selectedIndex == index
                  ? Pallete.blueColor
                  : Pallete.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
