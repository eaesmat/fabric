import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/select_colors_model.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignColorSheet extends StatefulWidget {
  const FabricDesignColorSheet({Key? key}) : super(key: key);

  @override
  State<FabricDesignColorSheet> createState() => _FabricDesignColorSheetState();
}

class _FabricDesignColorSheetState extends State<FabricDesignColorSheet> {
  List<SelectColorsModel> colors = [
    SelectColorsModel("جگری", false),
    SelectColorsModel("سبز", false),
    SelectColorsModel("سرخ", false),
    SelectColorsModel("سیاه", false),
    SelectColorsModel("گلابی", false),
    SelectColorsModel("سفید", false),
    SelectColorsModel("بنفش", false),
    SelectColorsModel("آبی", false),
    SelectColorsModel("یاسمندی", false),
    SelectColorsModel("آسمانی", false),
  ];

  List<SelectColorsModel> selectedColors = [];

  void printSelectedColorNames() {
    final fabricDesignColorController =
        Provider.of<FabricDesignColorController>(context, listen: false);

    for (var color in selectedColors) {
      print(color.colorName);
      fabricDesignColorController.colorNameController.text = color.colorName;
      fabricDesignColorController.createFabricDesignColor();
    }
  }

  // Color getColorFromName(String colorName) {
  //   switch (colorName.toLowerCase()) {
  //     case "جگری":
  //       return Colors.red.shade900;
  //     case "سبز":
  //       return Colors.green;
  //     case "سرخ":
  //       return Colors.red;
  //     case "سیاه":
  //       return Colors.black;
  //     case "گلابی":
  //       return Colors.pink;
  //     case "سفید":
  //       return Colors.white;
  //     case "بنفش":
  //       return Colors.purple;
  //     case "آبی":
  //       return Colors.blue;
  //     case "یاسمندی":
  //       return Colors.yellow;
  //     case "آسمانی":
  //       return Colors.blueAccent;
  //     default:
  //       return Pallete.blueColor; // Default color
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16.0),
        color: Pallete.whiteColor,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return colorItem(
                    colors[index].colorName,
                    colors[index].isSelected,
                    index,
                  );
                },
              ),
            ),
            selectedColors.isNotEmpty
                ? CustomDropDownButton(
                    onTap: () {
                      printSelectedColorNames();
                      Navigator.pop(context);
                    },
                    bgColor: Pallete.blueColor,
                    btnIcon: Text(
                      selectedColors.length.toString(),
                      style: const TextStyle(color: Pallete.whiteColor),
                    ),
                    btnText: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Pallete.whiteColor,
                        ),
                        LocaleText(
                          'create',
                          style: TextStyle(color: Pallete.whiteColor),
                        ),
                      ],
                    ),
                    btnWidth: 1,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget colorItem(String colorName, bool isSelected, int index) {
    return ListTileWidget(
      lead: CircleAvatar(
        backgroundColor: getColorFromName(colorName),
      ),
      tileTitle: Text(colorName),
      trail: isSelected
          ? const Icon(Icons.check_circle, color: Pallete.blueColor)
          : Icon(Icons.check_circle_outline, color: Colors.grey.shade700),
      onTap: () {
        setState(
          () {
            colors[index].isSelected = !colors[index].isSelected;
            if (colors[index].isSelected) {
              selectedColors.add(
                SelectColorsModel(colorName, true),
              );
            } else {
              selectedColors.removeWhere(
                  (element) => element.colorName == colors[index].colorName);
            }
          },
        );
      },
    );
  }
}
