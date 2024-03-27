import 'package:fabricproject/theme/pallete.dart';
import 'package:flutter/material.dart';

class SaraiOutFabricWidget extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  final String? indate;
  final String? bundle;
  final String? outDate;
  final String? outPlace;
  final String? patiName;
  final String? patiWar;

  const SaraiOutFabricWidget({
    Key? key,
    required this.title,
    this.patiName,
    this.patiWar,
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
                if (title != null)
                  _buildInfoRow(Icons.barcode_reader, title ?? ''),
                if (indate != null)
                  _buildInfoRow(Icons.calendar_month, indate ?? ''),
                if (bundle != null)
                  _buildInfoRow(Icons.view_module, bundle ?? ''),
                if (patiWar != null)
                  _buildInfoRow(Icons.view_module, patiWar.toString()),
                if (patiName != null)
                  _buildInfoRow(Icons.view_module, patiName.toString()),
                if (outDate != null)
                  _buildInfoRow(Icons.calendar_month, outDate ?? ''),
                if (outPlace != null)
                  _buildInfoRow(Icons.location_on, outPlace ?? ''),
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
            color: Pallete.blackColor,
            size: 20,
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
