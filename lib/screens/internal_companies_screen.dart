import 'package:fabricproject/providers/internal_companies/internal_comapnies_get_provider.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:fabricproject/widgets/locale_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompaniesScreen extends ConsumerWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internalCompanyData = ref.watch(internalCompanyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const LocaleTexts(localeText: 'internal_companies'),
      ),
      body: internalCompanyData.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final internalCompany = data[index];
              return ListTileWidget(
                lead: CircleAvatar(
                  backgroundColor: Pallete.blueColor,
                  child: Text(
                    internalCompany.marka.toString(),
                    style: const TextStyle(color: Pallete.whiteColor),
                  ),
                ),
                tileTitle: Text(
                  internalCompany.name.toString(),
                ),
                tileSubTitle: Text(
                  internalCompany.description.toString(),
                ),
                trail: Icon(Icons.edit),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
