import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/data/api/request/base_request.dart';
import 'package:fluttour/data/api/request/profile_request.dart';
import 'package:fluttour/data/api/request/signup_request.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/collection_grid/collection_grid_provider.dart';
import 'package:fluttour/pages/home/home_provider.dart';
import 'package:fluttour/pages/layout_state/layout_state_provider.dart';
import 'package:fluttour/pages/profile/edit_profile/edit_profile_provider.dart';
import 'package:fluttour/pages/profile/profile_provider.dart';
import 'package:fluttour/pages/signup/signup_provider.dart';
import 'package:fluttour/pages/tickets/tickets_provider.dart';
import 'package:fluttour/data/api/request/ticket_request.dart';
import 'package:fluttour/data/api/locale_provider.dart';
import 'package:fluttour/app_define/app_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/app_define/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.isAppAuthenticated}) : super(key: key);
  late final bool isAppAuthenticated;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppRoute appRoute = context.watch<AppRoute>();
    final LocaleProvider localeProvider = context.watch<LocaleProvider>();
    final AppTheme appTheme = context.theme();
    return MaterialApp(
      navigatorKey: appRoute.navigatorKey,
      locale: localeProvider.locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: widget.isAppAuthenticated ? AppRoute.routeHome : AppRoute.routeSignup,
      onGenerateRoute: appRoute.generateRoute,
      theme: appTheme.buildThemeData(),
      navigatorObservers: <NavigatorObserver>[appRoute.routeObserver],
    );
  }
}

Future<void> myMain() async {
  /// Start services later
  WidgetsFlutterBinding.ensureInitialized();

  /// Force status bar mode
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark
  ));

  /// Force portrait mode
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  /// We're using HiveStore for persistence,
  /// so we need to initialize Hive.
  await initHiveForFlutter();

  String? userToken = await Credential.singleton.getToken();

  runApp(
      MultiProvider(
          providers: <SingleChildWidget>[
            Provider<AppRoute>(
                create: (_) => AppRoute()
            ),
            Provider<BaseRequest>(
                create: (_) => BaseRequest()
            ),
            Provider<TicketRequest>(
                create: (_) => TicketRequest()
            ),
            Provider(
                create: (_) => SignupRequest()
            ),
            Provider(
                create: (_) => ProfileRequest()
            ),
            ChangeNotifierProvider<AppThemeProvider>(
                create: (_) => AppThemeProvider()
            ),
            ChangeNotifierProvider<HomeProvider>(
                create: (_) => HomeProvider()
            ),
            ChangeNotifierProvider<SignupProvider>(
                create: (BuildContext context) => SignupProvider(
                    context.read<BaseRequest>(),
                    context.read<SignupRequest>(),
                )),
            ChangeNotifierProvider<LayoutStateProvider>(
                create: (_) => LayoutStateProvider()
            ),
            ChangeNotifierProvider<CollectionGridProvider>(
                create: (_) => CollectionGridProvider()
            ),
            ChangeNotifierProvider<TicketsProvider>(
                create: (BuildContext context) => TicketsProvider(
                    context.read<TicketRequest>()
                )),
            ChangeNotifierProvider<ProfileProvider>(
                create: (BuildContext context) => ProfileProvider(
                    context.read<ProfileRequest>()
                )),
            ChangeNotifierProvider(
                create: (BuildContext context) => EditProfileProvider(
                    context.read<BaseRequest>(),
                    context.read<ProfileRequest>()
                )),
            ChangeNotifierProvider<LocaleProvider>(
                create: (_) => LocaleProvider()
            ),
          ],
          child: MyApp(isAppAuthenticated: (userToken != null)))
  );
}