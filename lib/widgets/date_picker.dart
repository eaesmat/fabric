import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;

  const DatePicker({Key? key, required this.controller}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Check if the controller has a value, if not, assign today's date
    if (widget.controller.text.isEmpty) {
      _selectedDate = DateTime.now();
      widget.controller.text =
          "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";
    } else {
      // If the controller has a value, use its value to set the selected date
      var dateSplit = widget.controller.text.split("-");
      int year = int.tryParse(dateSplit[0]) ?? DateTime.now().year;
      int month = int.tryParse(dateSplit[1]) ?? DateTime.now().month;
      int day = int.tryParse(dateSplit[2]) ?? DateTime.now().day;

      _selectedDate = DateTime(year, month, day);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Pallete.blueColor,
              onPrimary: Pallete.whiteColor,
              onSurface: Pallete.blueColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Pallete.blueColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text =
            "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: CustomTextFieldWithController(
        isDisabled: true,
        controller: widget.controller,
        iconBtn: const Icon(
          size: 30,
          Icons.date_range,
          color: Pallete.blueColor,
        ),
        lblText: const LocaleText('date'),
      ),
    );
  }
}
