import 'package:fabricproject/controller/all_fabric_purchases_controller.dart';
import 'package:fabricproject/controller/colors_controller.dart';
import 'package:fabricproject/controller/dokan_pati_controller.dart';
import 'package:fabricproject/controller/dokan_pati_in_controller.dart';
import 'package:fabricproject/controller/dokan_pati_out_controller.dart';
import 'package:fabricproject/controller/dokan_pati_select_controller.dart';
import 'package:fabricproject/controller/fabric_design_toop_controller.dart';
import 'package:fabricproject/controller/forex_calculation_controller%20copy.dart';
import 'package:fabricproject/controller/forex_calculation_controller.dart';
import 'package:fabricproject/controller/forex_gereft_controller.dart';
import 'package:fabricproject/controller/khalid_gereft_controller.dart';
import 'package:fabricproject/controller/sarai_fabric_bundle_select_controller.dart';
import 'package:fabricproject/controller/sarai_fabric_purchase_controller.dart';
import 'package:fabricproject/controller/sarai_in_fabric_controller.dart';
import 'package:fabricproject/controller/sarai_item_controller.dart';
import 'package:fabricproject/controller/company_controller.dart';
import 'package:fabricproject/controller/customer_deal_controller.dart';
import 'package:fabricproject/controller/customer_deals_controller.dart';
import 'package:fabricproject/controller/customer_payment_controller.dart';
import 'package:fabricproject/controller/fabric_controller.dart';
import 'package:fabricproject/controller/fabric_design_bundle_controller.dart';
import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/controller/khalid_rasid_controller.dart';
import 'package:fabricproject/controller/pati_controller.dart';
import 'package:fabricproject/controller/pati_design_color_controller.dart';
import 'package:fabricproject/controller/sarai_controller.dart';
import 'package:fabricproject/controller/sarai_in_deal_controller.dart';
import 'package:fabricproject/controller/sarai_marka_controller.dart';
import 'package:fabricproject/controller/sarai_out_fabric_controller.dart';
import 'package:fabricproject/controller/tranfser_dokan_pati_controller.dart';
import 'package:fabricproject/controller/transport_controller.dart';
import 'package:fabricproject/controller/transport_deals_controller.dart';
import 'package:fabricproject/controller/transport_payment_controller.dart';
import 'package:fabricproject/controller/transfer_bundles_controller.dart';
import 'package:fabricproject/controller/user_controller.dart';
import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'fa','ar']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerController>(
          create: (_) => CustomerController(HelperServices.instance),
        ),
        ChangeNotifierProvider<ForexController>(
          create: (_) => ForexController(HelperServices.instance),
        ),
        ChangeNotifierProvider<CompanyController>(
          create: (_) => CompanyController(HelperServices.instance),
        ),
        ChangeNotifierProvider<FabricController>(
          create: (_) => FabricController(HelperServices.instance),
        ),
        ChangeNotifierProvider<VendorCompanyController>(
          create: (_) => VendorCompanyController(HelperServices.instance),
        ),
        ChangeNotifierProvider<TransportController>(
          create: (_) => TransportController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiController>(
          create: (_) => SaraiController(HelperServices.instance),
        ),
       
        ChangeNotifierProvider<KhalidRasidController>(
          create: (_) => KhalidRasidController(HelperServices.instance),
        ),
        ChangeNotifierProvider<FabricDesignController>(
          create: (_) => FabricDesignController(HelperServices.instance),
        ),
        ChangeNotifierProvider<FabricDesignColorController>(
          create: (_) => FabricDesignColorController(HelperServices.instance),
        ),
        ChangeNotifierProvider<FabricDesignBundleController>(
          create: (_) => FabricDesignBundleController(HelperServices.instance),
        ),

        ChangeNotifierProvider<FabricDesignToopController>(
          create: (_) => FabricDesignToopController(HelperServices.instance),
        ),
        ChangeNotifierProvider<TransportPaymentController>(
          create: (_) => TransportPaymentController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiInDealController>(
          create: (_) => SaraiInDealController(HelperServices.instance),
        ),
        ChangeNotifierProvider<ColorsController>(
          create: (_) => ColorsController(HelperServices.instance),
        ),
        ChangeNotifierProvider<ForexCalculationController>(
          create: (_) => ForexCalculationController(HelperServices.instance),
        ),
        ChangeNotifierProvider<PatiController>(
          create: (_) => PatiController(HelperServices.instance),
        ),
        ChangeNotifierProvider<CustomerDealController>(
          create: (_) => CustomerDealController(HelperServices.instance),
        ),
        ChangeNotifierProvider<CustomerPaymentController>(
          create: (_) => CustomerPaymentController(HelperServices.instance),
        ),
        ChangeNotifierProvider<CustomerDealsController>(
          create: (_) => CustomerDealsController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiItemController>(
          create: (_) => SaraiItemController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiInFabricController>(
          create: (_) => SaraiInFabricController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiOutFabricController>(
          create: (_) => SaraiOutFabricController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiMarkaController>(
          create: (_) => SaraiMarkaController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiFabricPurchaseController>(
          create: (_) => SaraiFabricPurchaseController(HelperServices.instance),
        ),
        ChangeNotifierProvider<SaraiFabricBundleSelectController>(
          create: (_) =>
              SaraiFabricBundleSelectController(HelperServices.instance),
        ),
        ChangeNotifierProvider<TransferBundlesController>(
          create: (_) => TransferBundlesController(HelperServices.instance),
        ),
        ChangeNotifierProvider<DokanPatiController>(
          create: (_) => DokanPatiController(HelperServices.instance),
        ),
        ChangeNotifierProvider<DokanInPatiController>(
          create: (_) => DokanInPatiController(HelperServices.instance),
        ),
        ChangeNotifierProvider<DokanOutPatiController>(
          create: (_) => DokanOutPatiController(HelperServices.instance),
        ),
        ChangeNotifierProvider<DokanPatiSelectController>(
          create: (_) => DokanPatiSelectController(HelperServices.instance),
        ),
        ChangeNotifierProvider<TransferDokanPatiController>(
          create: (_) => TransferDokanPatiController(HelperServices.instance),
        ),
        ChangeNotifierProvider<TransportDealsController>(
          create: (_) => TransportDealsController(HelperServices.instance),
        ),
        ChangeNotifierProvider<AllFabricPurchasesController>(
          create: (_) => AllFabricPurchasesController(HelperServices.instance),
        ),
        ChangeNotifierProvider<KhalidGereftController>(
          create: (_) => KhalidGereftController(HelperServices.instance),
        ),
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(HelperServices.instance),
        ),
        ChangeNotifierProvider<ForexGereftController>(
          create: (_) => ForexGereftController(HelperServices.instance),
        ),
        ChangeNotifierProvider<ForexTalabatController>(
          create: (_) => ForexTalabatController(HelperServices.instance),
        ),
      ],
      child: LocaleBuilder(
        builder: (locale) => MaterialApp(
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          
          navigatorKey: HelperServices.instance.navigationKey,
          debugShowCheckedModeBanner: false,
          locale: locale,
          theme: Pallete.lightModeAppTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
