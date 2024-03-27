import 'package:fabricproject/screens/vendor_company/vendor_calculation_list_screen.dart';
import 'package:fabricproject/screens/vendor_company/vendor_company_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class VendorCompaniesDetailsScreen extends StatefulWidget {
  const VendorCompaniesDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VendorCompaniesDetailsScreen> createState() =>
      _VendorCompaniesDetailsScreenState();
}

class _VendorCompaniesDetailsScreenState
    extends State<VendorCompaniesDetailsScreen> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleTexts(localeText: 'vendor_companies'),
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
                  _buildTab(Icons.list_alt_sharp, 'vendor_companies', 0),
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
            VendorCompanyListScreen(),
            VendorCalculationListScreen(),
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
