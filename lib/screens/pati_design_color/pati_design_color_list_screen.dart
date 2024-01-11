import 'package:fabricproject/controller/pati_controller.dart';
import 'package:fabricproject/controller/pati_design_color_controller.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class PatiDesignColorListScreen extends StatefulWidget {
  final int? patiId;
  final String? patiName;
  final String? patiToop;

  const PatiDesignColorListScreen({
    Key? key,
    this.patiName,
    this.patiId,
    this.patiToop,
  }) : super(key: key);

  @override
  State<PatiDesignColorListScreen> createState() =>
      _PatiDesignColorListScreenState();
}

class _PatiDesignColorListScreenState extends State<PatiDesignColorListScreen> {
  late TextEditingController _toopController;

  @override
  void initState() {
    super.initState();
    _toopController = TextEditingController(text: widget.patiToop);
  }

  @override
  void dispose() {
    _toopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patiDesignColorController =
        Provider.of<PatiDesignColorController>(context);

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
              // Display CustomTextFieldWithController for data.pati!.toop.toString() once
              if (patiDesignColorController.searchPatiDesignColors != null &&
                  patiDesignColorController.searchPatiDesignColors!.isNotEmpty)
                CustomTextFieldWithController(
                  lblText: LocaleText('toop'),
                  controller: _toopController,
                ),
              // ListView.builder for CustomTextFieldWithController for data.fabricdesigncolor!.colorname.toString()
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    patiDesignColorController.searchPatiDesignColors?.length ??
                        0,
                itemBuilder: (context, index) {
                  final data = patiDesignColorController
                      .searchPatiDesignColors!.reversed
                      .toList()[index];
                  TextEditingController textFieldController =
                      TextEditingController(text: data.war.toString());

                  return CustomTextFieldWithController(
                    iconBtn: IconButton(
                      icon: const Icon(
                        Icons.add_box,
                        color: Pallete.blueColor,
                      ),
                      onPressed: () {
                        // navigate to new create screen
                        print(data.patidesigncolorId);
                        print(data.fabricdesigncolor!.colorname);
                        print(data.war);
                        patiDesignColorController.warController.text =
                            data.war.toString();
                        patiDesignColorController.warController.text =
                            textFieldController.text;
                        patiDesignColorController.editPatiDesignColor(
                            data.patidesigncolorId!.toInt(), data);
                      },
                    ),
                    controller:
                        textFieldController, // Assign the created controller here
                    // controller: TextEditingController(
                    //   text: data.war.toString(),
                    // ),
                    lblText: LocaleText(
                      data.fabricdesigncolor!.colorname.toString(),
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
