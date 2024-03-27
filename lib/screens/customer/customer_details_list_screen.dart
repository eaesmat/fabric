import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/screens/customer/customer_balance_list_screen.dart';
import 'package:fabricproject/screens/customer/customer_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CustomerDetailsListScreen extends StatefulWidget {
  const CustomerDetailsListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerDetailsListScreen> createState() =>
      _CustomerDetailsListScreenState();
}

class _CustomerDetailsListScreenState extends State<CustomerDetailsListScreen> {
  int _selectedIndex = 0;
  late PageController _pageController; // Define PageController here

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCustomerCalculation = Provider.of<CustomerController>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleTexts(localeText: 'Customers'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                dividerColor: Pallete.whiteColor,
                indicatorColor: Colors.transparent,
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
                  _buildTab(Icons.list_alt_sharp, 'customers', 0),
                  _buildTab(Icons.equalizer, 'balance', 1),
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
          children: const [
            CustomerListScreen(),
            CustomerBalanceListScreen(),
          ],
        ),
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CalculationBottomNavigationBar(
            rowsData: [
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.US, height: 20, width: 20),
                textKey: 'total_cost_dollar',
                remainingValue:
                    allCustomerCalculation.allTotalCostDoller.toString(),
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.US, height: 20, width: 20),
                textKey: 'total_dollar_payment',
                remainingValue:
                    allCustomerCalculation.allPaymentDoller.toString(),
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.US, height: 20, width: 20),
                textKey: 'total_due_dollar',
                remainingValue: allCustomerCalculation.allDueDoller.toString(),
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
                textKey: 'total_cost_afghani',
                remainingValue:
                    allCustomerCalculation.allTotalCostAfghani.toString(),
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
                textKey: 'total_payment_afghani',
                remainingValue:
                    allCustomerCalculation.allPaymentAfghani.toString(),
              ),
              RowData(
                customWidget:
                    Flag.fromCode(FlagsCode.AF, height: 20, width: 20),
                textKey: 'total_due_afghani',
                remainingValue: allCustomerCalculation.allDueAfghani.toString(),
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
