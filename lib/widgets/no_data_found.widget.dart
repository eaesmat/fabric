import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align contents vertically centered
          children: [
            Image.asset(
              'assets/images/noData.png',
            ),
            const LocaleTexts(localeText: 'no_data'),
          ],
        ),
      ),
    );
  }
}
