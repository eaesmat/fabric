import 'package:fabricproject/controller/company_controller.dart';
import 'package:fabricproject/controller/draw_controller.dart';
import 'package:fabricproject/controller/fabric_controller.dart';
import 'package:fabricproject/controller/fabric_design_bundle_controller.dart';
import 'package:fabricproject/controller/fabric_design_color_controller.dart';
import 'package:fabricproject/controller/fabric_design_controller.dart';
import 'package:fabricproject/controller/fabric_purchase_controller.dart';
import 'package:fabricproject/controller/forex_controller.dart';
import 'package:fabricproject/controller/sarai_controller.dart';
import 'package:fabricproject/controller/transport_controller.dart';
import 'package:fabricproject/controller/vendor_company_controller.dart';
import 'package:fabricproject/helper/helper.dart';
import 'package:fabricproject/controller/customer_controller.dart';
import 'package:fabricproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'fa', 'ps']);
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
        ChangeNotifierProvider<FabricPurchaseController>(
          create: (_) => FabricPurchaseController(HelperServices.instance),
        ),
        ChangeNotifierProvider<DrawController>(
          create: (_) => DrawController(HelperServices.instance),
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
      ],
      child: LocaleBuilder(
        builder: (locale) => MaterialApp(
          localizationsDelegates: const [
            ...Locales.delegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          navigatorKey: HelperServices.instance.navigationKey,
          debugShowCheckedModeBanner: false,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          theme: Pallete.lightModeAppTheme,
          home: const SplashScreen(),
          // home: const CustomerListScreen(),
        ),
      ),
    );
  }
}
