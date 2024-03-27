import 'package:fabricproject/controller/customer_deals_controller.dart';
import 'package:fabricproject/screens/customer_deal/customer_deals_list_screen.dart';
import 'package:fabricproject/screens/customer_rasidat/customer_rasidat_list_screen.dart';
import 'package:fabricproject/screens/customer_sales/customer_sales_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerDetailsScreen extends StatefulWidget {
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
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCustomerCalculation =
        Provider.of<CustomerDealsController>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextTitle(text: widget.customerName),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.transparent,
                dividerColor: Pallete.whiteColor,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                    _pageController.animateToPage(
                      _selectedIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
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
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            CustomerDealsListScreen(customerId: widget.customerId),
            CustomerSalesListScreen(customerId: widget.customerId),
            CustomerRasidatListScreen(customerId: widget.customerId)
          ],
        ),
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CalculationBottomNavigationBar(
            rowsData: [
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.US, height: 20, width: 20),
                textKey: 'total_due_dollar',
                remainingValue:
                    allCustomerCalculation.dollorDue?.toString() ?? '0',
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.US, height: 20, width: 20),
                textKey: 'total_dollar_payment',
                remainingValue:
                    allCustomerCalculation.dollorPayment?.toString() ?? '0',
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.US, height: 20, width: 20),
                textKey: 'deals',
                remainingValue:
                    allCustomerCalculation.dollorDeal?.toString() ?? '0',
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
                textKey: 'total_due_afghani',
                remainingValue:
                    allCustomerCalculation.afghaniDeal?.toString() ?? '0',
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
                textKey: 'total_payment_afghani',
                remainingValue:
                    allCustomerCalculation.afghaniPayment?.toString() ?? '0',
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
                textKey: 'deals',
                remainingValue:
                    allCustomerCalculation.afghaniDeal?.toString() ?? '0',
              ),
            ],
          ),
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
                : Pallete.blackColor,
          ),
          const SizedBox(width: 8),
          LocaleText(
            text,
            style: TextStyle(
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
