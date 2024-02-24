import 'package:fabricproject/controller/sarai_fabric_bundle_select_controller.dart';
import 'package:fabricproject/screens/dokan_pati/dokan_pati_list_screen.dart';
import 'package:fabricproject/screens/sarai_item_list/sarai_item_list_screen.dart';
import 'package:fabricproject/screens/sarai_item_list/sarai_transfer_screen.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class SaraiDetailsScreen extends StatefulWidget {
  final int saraiId;
  final String saraiName;
  final String saraiType;

  const SaraiDetailsScreen({
    Key? key,
    required this.saraiId,
    required this.saraiName,
    required this.saraiType,
  }) : super(key: key);

  @override
  State<SaraiDetailsScreen> createState() => _SaraiDetailsScreenState();
}

class _SaraiDetailsScreenState extends State<SaraiDetailsScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SaraiFabricBundleSelectController>(context, listen: false)
          .resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _getTabCount(),
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextTitle(
            text: "${widget.saraiName}  [ ${widget.saraiType} ]",
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: _buildTabs(),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: _buildTabViews(),
        ),
      ),
    );
  }

  List<Widget> _buildTabViews() {
    switch (widget.saraiType) {
      case 'دوکان':
        return [
          DokanPatiListScreen(dokanId: widget.saraiId),
          SaraiTransferScreen(saraiId: widget.saraiId.toInt()),
          Container(color: Colors.green),
        ];
      case 'گدام':
        return [
          SaraiItemListScreen(saraiId: widget.saraiId),
          SaraiTransferScreen(saraiId: widget.saraiId.toInt()),
        ];
      case 'تخلیه':
        return [
          SaraiItemListScreen(saraiId: widget.saraiId),
          SaraiTransferScreen(saraiId: widget.saraiId.toInt()),
          Container(color: Colors.red),
        ];
      default:
        return [
          SaraiItemListScreen(saraiId: widget.saraiId),
          SaraiTransferScreen(saraiId: widget.saraiId.toInt()),
          Container(color: Colors.black),
        ];
    }
  }

  List<Widget> _buildTabs() {
    switch (widget.saraiType) {
      case 'دوکان':
        return [
          _buildTab(Icons.assignment, 'item', 0),
          _buildTab(Icons.integration_instructions_rounded, 'transfers', 1),
          _buildTab(Icons.assignment_returned, 'pati', 2),
        ];
      case 'تخلیه':
        return [
          _buildTab(Icons.assignment, 'item', 0),
          _buildTab(Icons.integration_instructions_rounded, 'transfers', 1),
          _buildTab(Icons.assignment_returned, 'received', 2),
        ];
      case 'گدام':
      default:
        return [
          _buildTab(Icons.assignment, 'item', 0),
          _buildTab(Icons.integration_instructions_rounded, 'transfers', 1),
        ];
    }
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

  int _getTabCount() {
    switch (widget.saraiType) {
      case 'دوکان':
      case 'تخلیه':
        return 3;
      case 'گدام':
      default:
        return 2;
    }
  }
}
