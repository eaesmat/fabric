import 'package:fabricproject/screens/hesabat_china/hesabat_china_purchase_list_screen.dart';
import 'package:fabricproject/screens/vendorcompany_rasid/vendorcompany_rasid_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class HesabatChinaDetailsScreen extends StatefulWidget {
  final String vendorCompanyName;
  final int vendorCompanyId;
  const HesabatChinaDetailsScreen({
    Key? key,
    required this.vendorCompanyName,
    required this.vendorCompanyId,
  }) : super(key: key);

  @override
  State<HesabatChinaDetailsScreen> createState() =>
      _HesabatChinaDetailsScreenState();
}

class _HesabatChinaDetailsScreenState extends State<HesabatChinaDetailsScreen> {
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
          title: CustomTextTitle(text: widget.vendorCompanyName),
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
            HesabatChinaPurchaseListScreen(
                vendorCompanyId: widget.vendorCompanyId,
                vendorCompanyName: widget.vendorCompanyName),
            VendorCompanyRasidListScreen(
                vendorCompanyId: widget.vendorCompanyId,
                vendorCompanyName: widget.vendorCompanyName),
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
