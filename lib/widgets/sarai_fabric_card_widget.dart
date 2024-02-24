import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:intl/intl.dart';

class SaraiFabricsCardWidget extends StatelessWidget {
  final String name;
  final String totalBundle;
  final String inItems;
  final String outItems;
  final String? totalPati;
  final String? inDate;
  final VoidCallback? onRedButtonPressed;
  final VoidCallback? onGreenButtonPressed;

  const SaraiFabricsCardWidget({
    Key? key,
    required this.name,
    required this.totalBundle,
    required this.inItems,
    required this.outItems,
    this.inDate,
    this.totalPati,
    this.onRedButtonPressed,
    this.onGreenButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? parsedInDate;
    String? formattedInDate;

    if (inDate != null) {
      try {
        parsedInDate =
            DateTime.parse(inDate!); // Parsing the date string to DateTime
        formattedInDate = DateFormat('MMM dd, yyyy')
            .format(parsedInDate); // Format the parsed date
        // ignore: empty_catches
      } catch (e) {}
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height *
                0.6, // Increase the minHeight as needed
          ),
          child: Column(
            children: [
              Expanded(
                child: FabricDateCard(
                  name: name,
                  inDate: formattedInDate,
                  inItems: int.parse(inItems),
                  totalPati: totalPati,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FabricDetailsCard(
                        bgColor: Colors.blue.shade100,
                        icon: const Icon(Icons.compare_arrows),
                        button: CircularButton(
                          backgroundColor: Colors.blue.shade400,
                          label: totalBundle,
                        ),
                        actionText: const LocaleText('total'),
                      ),
                    ),
                    Expanded(
                      child: FabricDetailsCard(
                        bgColor: Colors.green.shade100,
                        icon: const Icon(Icons.arrow_downward),
                        button: CircularButton(
                          backgroundColor: Colors.green.shade400,
                          label: inItems,
                          onPressed: onGreenButtonPressed,
                        ),
                        actionText: const LocaleText('receipt'),
                      ),
                    ),
                    Expanded(
                      child: FabricDetailsCard(
                        bgColor: Colors.red.shade100,
                        icon: const Icon(Icons.arrow_upward),
                        button: CircularButton(
                          backgroundColor: Colors.red.shade400,
                          label: outItems,
                          onPressed: onRedButtonPressed,
                        ),
                        actionText: const LocaleText('transferred'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FabricDetailsCard extends StatelessWidget {
  final Widget? icon; // Change Widget? to Widget
  final Color? bgColor;
  final Widget? actionText;
  final Widget? button;

  const FabricDetailsCard({
    Key? key,
    this.icon, // Make icon non-nullable
    this.bgColor,
    this.actionText,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 0,
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            // Center the column
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                Center(child: button), // Center the button
                const Divider(color: Pallete.whiteColor),
                Center(child: icon), // Center the icon
                const Divider(color: Pallete.whiteColor),
                Center(child: actionText), // Center the icon
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FabricDateCard extends StatelessWidget {
  final String? inDate; // String parameter for the inDate
  final String name;
  final int  inItems;
  
  final String? totalPati;

  const FabricDateCard(
      {Key? key, required this.inDate, required this.name, this.totalPati, required this.inItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        inItems == 0  ? Colors.red.shade400 : Colors.green.shade400;
    Widget actionIcon = inDate == null
        ? CircleAvatar(
            backgroundColor: Pallete.whiteColor,
            maxRadius: 12,
            child: Icon(
              Icons.close_outlined,
              size: 20,
              color: Pallete.redColor,
            ),
          )
        : Icon(
            Icons.check_circle,
            size: 27,
            color: Pallete.whiteColor,
          );

    return SizedBox(
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), // Set top left radius
            topRight: Radius.circular(
                10.0), // Set top right radius // Set bottom right radius
          ),
        ),
        color: backgroundColor, // Background color for the first part
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // First section taking 30% width
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FabricDetailsCard(
                        // as button accept widget so I Passed Text instead of any buttons
                        button: Icon(
                          Icons.date_range_rounded,
                          size: 24,
                          color: Pallete.whiteColor,
                        ),
                        icon: Text(
                          inDate?.toString() ?? '--/--/----',
                          style: TextStyle(
                            color: Pallete.whiteColor,
                          ),
                        ),
                        actionText: actionIcon,
                        bgColor: Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),

              // Second section taking remaining width
              Expanded(
                flex: 8,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          totalPati != null && totalPati?.isNotEmpty == true
                              ? FabricDetailsCard(
                                  // as button accept widget so I Passed Text instead of any buttons
                                  button: Text(
                                    name,
                                    style: const TextStyle(
                                        color: Pallete.whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ), // Displaying full date if available
                                  icon: CircularButton(
                                    backgroundColor: Colors.blue.shade400,
                                    label: totalPati.toString(),
                                  ),
                                  actionText: LocaleText('total_pati',
                                      style: TextStyle(color: Colors.white)),
                                  bgColor: Colors.white24,
                                )
                              : Text(
                                  name,
                                  style: const TextStyle(
                                      color: Pallete.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ), // Displaying full date if available, // or any other widget to show when totalPati is null or empty

                          // Displaying full date if available
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final VoidCallback? onPressed;

  const CircularButton({
    Key? key,
    required this.backgroundColor,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 35,
        height: 35,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
