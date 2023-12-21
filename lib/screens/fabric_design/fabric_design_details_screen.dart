import 'package:fabricproject/screens/fabric_design%20_color/fabric_design_color_list_screen.dart';
import 'package:fabricproject/screens/fabric_design_bundle/fabric_design_bundle_list_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FabricDesignDetailsScreen extends StatefulWidget {
  final int fabricDesignId;
  final String fabricDesignName;
  const FabricDesignDetailsScreen({
    Key? key,
    required this.fabricDesignId,
    required this.fabricDesignName,
  }) : super(key: key);

  @override
  State<FabricDesignDetailsScreen> createState() =>
      _FabricDesignDetailsScreenState();
}

class _FabricDesignDetailsScreenState extends State<FabricDesignDetailsScreen> {
  int _selectedIndex = 0; // Track the selected tab index

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
                  _buildTab(Icons.production_quantity_limits, 'bundle', 0),
                  _buildTab(Icons.color_lens, 'colors', 1),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // FabricPurchaseListScreen(
            //   vendorCompanyId: widget.vendorCompanyId,
            //   vendorCompanyName: widget.vendorCompanyName,
            // ),
            // DrawListScreen(
            //   vendorCompanyId: widget.vendorCompanyId,
            //   vendorCompanyName: widget.vendorCompanyName,
            // ),
            // const DrawCalculation(),
            FabricDesignBundleListScreen(
              fabricDesignId: widget.fabricDesignId,
              fabricDesignName: widget.fabricDesignName,
            ),

            FabricDesignColorListScreen(
              fabricDesignId: widget.fabricDesignId,
              fabricDesignName: widget.fabricDesignName,
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
                : Pallete.blackColor, // Change color based on selection
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
