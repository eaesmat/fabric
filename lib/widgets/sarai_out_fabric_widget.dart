import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class SaraiOutFabricWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String indate;
  final String bundle;
  final String outDate;
  final String outPlace;

  const SaraiOutFabricWidget({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.indate,
    required this.bundle,
    required this.outDate,
    required this.outPlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: backgroundColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.barcode_reader, title),
                _buildInfoRow(Icons.calendar_month, indate),
                _buildInfoRow(Icons.view_module, bundle),
                _buildInfoRow(Icons.calendar_month, outDate),
                _buildInfoRow(Icons.location_on, outPlace),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Pallete.blackColor,size: 20,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Pallete.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
