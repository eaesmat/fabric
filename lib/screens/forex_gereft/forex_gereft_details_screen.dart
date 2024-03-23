import 'package:fabricproject/screens/forex/forex_calculation_list_screen.dart';
import 'package:fabricproject/screens/forex_gereft/forex_gereft_list_screen.dart';
import 'package:fabricproject/screens/forex_gereft/forex_talabat_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ForexGereftDetailsScreen extends StatefulWidget {
  final String forexName;
  final int forexId;
  const ForexGereftDetailsScreen({
    Key? key,
    required this.forexName,
    required this.forexId,
  }) : super(key: key);

  @override
  State<ForexGereftDetailsScreen> createState() =>
      _ForexGereftDetailsScreenState();
}

class _ForexGereftDetailsScreenState extends State<ForexGereftDetailsScreen> {
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
          title: const LocaleTexts(localeText: 'sarafi'),
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
                  _buildTab(Icons.fact_check_sharp, 'withdrawal', 0),
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
            ForexGereftListScreen(
              forexId: widget.forexId,
              forexName: widget.forexName,
            ),
            ForexTalabatListScreen(
              forexId: widget.forexId,
            ),
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
