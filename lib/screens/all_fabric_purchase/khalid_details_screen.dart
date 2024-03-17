import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/screens/all_fabric_purchase/all_fabric_purchase_list_screen.dart';
import 'package:fabricproject/screens/khalid_gereft/khalid_gereft_list_screen.dart';
import 'package:fabricproject/screens/khalid_rasid/khalid_rasid_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:fabricproject/widgets/calculation_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class KhalidDetailsScreen extends StatefulWidget {
  const KhalidDetailsScreen({Key? key}) : super(key: key);

  @override
  State<KhalidDetailsScreen> createState() => _KhalidDetailsScreenState();
}

class _KhalidDetailsScreenState extends State<KhalidDetailsScreen> {
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
    final allFabricPurchasesConroller =
        Provider.of<AllFabricPurchasesController>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleTexts(localeText: 'khalid_account'),
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
                  _buildTab(Icons.list_alt_sharp, 'purchases', 0),
                  _buildTab(Icons.draw, 'receipts', 1),
                  _buildTab(Icons.fact_check_sharp, 'withdrawal', 2),
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
            AllFabricPurchaseListScreen(),
            KhalidRasidListScreen(),
            KhalidGereftListScreen(),
          ],
        ),
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CalculationBottomNavigationBar(
            rowsData: [
              RowData(
                icon: Icons.balance,
                textKey: 'KLDMD',
                remainingValue:
                    allFabricPurchasesConroller.kldhmd.toString().toString(),
                // Access the balance from the first item in khalidCalculation list
              ),
              RowData(
                icon: Icons.draw,
                textKey: 'draw',
                remainingValue: allFabricPurchasesConroller.submitDoller
                    .toString(), // Access the kldhmd from the first item in khalidCalculation list
                iconColor: Pallete.redColor,
                textColor: Pallete.redColor,
              ),
              RowData(
                icon: Icons.fact_check_sharp,
                textKey: 'deposit',
                remainingValue: allFabricPurchasesConroller.totalDollerPirce
                    .toString(), // Access the kldhmd from the first item in khalidCalculation list
              ),
              RowData(
                icon: Icons.equalizer,
                textKey: 'balance',
                remainingValue: allFabricPurchasesConroller.balance
                    .toString(), // Access the kldhmd from the first item in khalidCalculation list
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
