import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/model/fabric_design_color_model.dart';
import 'package:fabricproject/screens/fabric_design%20_color/color_button_sheet.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_drop_down_button.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class FabricDesignColorEditScreen extends StatefulWidget {
  final Data fabricDesignColorData;
  final int fabricDesignColorId;
  const FabricDesignColorEditScreen({
    super.key,
    required this.fabricDesignColorData,
    required this.fabricDesignColorId,
  });

  @override
  State<FabricDesignColorEditScreen> createState() =>
      _FabricDesignColorEditScreenState();
}

class _FabricDesignColorEditScreenState
    extends State<FabricDesignColorEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fabricDesignColorController =
        Provider.of<FabricDesignColorController>(context);
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'edit_fabric_design_color'),
        centerTitle: true,
      ),
      body: Dialog.fullscreen(
        backgroundColor: Pallete.whiteColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const ColorBottomSheet();
                        },
                      );
                    },
                    child: CustomTextFieldWithController(
                      customValidator: (value) =>
                          customValidator(value, currentLocale),
                      isDisabled: true,
                      controller: fabricDesignColorController
                          .selectedColorNameController,
                      iconBtn: const Icon(
                        size: 30,
                        Icons.add_box_rounded,
                        color: Pallete.blueColor,
                      ),
                      lblText: const LocaleText('color'),
                    ),
                  ),
                  CustomTextFieldWithController(
                    controller: fabricDesignColorController.photoController,
                    lblText: const LocaleText('photo'),
                  ),
                  CustomDropDownButton(
                    btnWidth: 1,
                    btnIcon: const Icon(
                      Icons.check,
                      color: Pallete.whiteColor,
                    ),
                    btnText: const LocaleText(
                      'update',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    bgColor: Pallete.blueColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        fabricDesignColorController.editFabricDesignColor(
                          widget.fabricDesignColorId,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
