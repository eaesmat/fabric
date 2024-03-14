import 'package:fabricproject/screens/fabric_design%20_color/fabric_design_color_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignDetailsScreen extends StatefulWidget {
  final int fabricDesignId;
  final String fabricDesignName;
  final int colorCount;
  final int colorLength;
  const FabricDesignDetailsScreen({
    Key? key,
    required this.fabricDesignId,
    required this.fabricDesignName,
    required this.colorCount,
    required this.colorLength,
  }) : super(key: key);

  @override
  State<FabricDesignDetailsScreen> createState() =>
      _FabricDesignDetailsScreenState();
}

class _FabricDesignDetailsScreenState extends State<FabricDesignDetailsScreen> {
  late PageController _pageController; // Define PageController here
  int _selectedIndex = 0; // Track the selected tab index

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
          title: CustomTextTitle(text: widget.fabricDesignName),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(30), // Adjust the height of the TabBar
            child: Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.transparent, // Hide the indicator
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index; // Update selected index
                    _pageController.animateToPage(
                      _selectedIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                tabs: [
                  _buildTab(Icons.color_lens, 'colors', 0),
                  _buildTab(Icons.assignment, 'bundle', 1),
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
            if (widget.colorCount == 0)
              FabricDesignColorListScreen(
                fabricDesignId: widget.fabricDesignId,
                fabricDesignName: widget.fabricDesignName,
              )
            else
              _buildNoBundleWidget(
                  'toops_are_added_can_not_add_new_color'), // Show custom widget if no bundle
            widget.colorLength != 0
                ? Center(
                    child: Text(
                      'Bundle',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _selectedIndex == 1
                            ? Pallete.blueColor
                            : Pallete.blackColor,
                      ),
                    ),
                  )
                : _buildNoBundleWidget(
                    'no_colors_are_added'), // Show custom widget if no bundle
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

  Widget _buildNoBundleWidget(String warningText) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/isComplete.png',
          ),
          const Icon(
            Icons.warning,
            size: 60,
            color: Colors.deepOrange,
          ),
          LocaleText(
            warningText,
            style: const TextStyle(
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}
