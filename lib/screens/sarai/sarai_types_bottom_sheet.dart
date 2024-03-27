import 'package:fabricproject/controller/sarai_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaraiTypesButtonSheet extends StatefulWidget {
  const SaraiTypesButtonSheet({Key? key});

  @override
  State<SaraiTypesButtonSheet> createState() => _SaraiTypesButtonSheetState();
}

class _SaraiTypesButtonSheetState extends State<SaraiTypesButtonSheet> {
  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final saraiController = Provider.of<SaraiController>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        color: Pallete.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Title for the bottom sheet
              LocaleTexts(localeText: 'Sarai Type'),
              const SizedBox(height: 20),

              // Use a ListView.builder to create a list of items
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3, // Set the number of items
                itemBuilder: (context, index) {
                  // Data for each item (replace with your static data)
                  final names = ['دوکان', 'گدام', 'تخلیه'];
                  final data = {
                    'name': names[index],
                  };
                  // Define icons based on data['name']
                  IconData iconData;
                  switch (data['name']) {
                    case 'دوکان':
                      iconData = Icons.store;
                      break;
                    case 'گدام':
                      iconData = Icons.warehouse;
                      break;
                    case 'تخلیه':
                      iconData = Icons.local_shipping;
                      break;
                    default:
                      iconData = Icons.error;
                      break;
                  }

                  return ListTileWidget(
                    onTap: () {
                      // Handle item tap
                      saraiController.typeController.text =
                          data['name'].toString();
                      Navigator.pop(context);
                    },
                    lead: Icon(iconData),
                    tileTitle: Text(
                      showSaraiType(data['name'].toString(), currentLocale),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
