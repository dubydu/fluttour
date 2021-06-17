import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/pages/collection_grid/p_collection_grid.dart';
import 'package:fluttour/pages/home/p_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/pages/layout_state/p_layout_state.dart';
import 'package:fluttour/pages/profile/edit_profile/p_edit_profile.dart';
import 'package:fluttour/pages/profile/p_profile.dart';
import 'package:fluttour/pages/signup/p_signup.dart';
import 'package:fluttour/pages/tickets/p_tickets.dart';
import 'package:provider/provider.dart';

class AppRoute {
  static final AppRoute _shared = AppRoute._private();

  factory AppRoute() {
    return _shared;
  }

  AppRoute._private();

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeHome = '/home';
  static const String routeSignup = '/sign_up';
  static const String routeLayoutState = '/layout_state';
  static const String routeCollectionGrid = '/collection_grid';
  static const String routeFetchData = '/fetch_data';
  static const String routeDataMutations = '/data_mutations';
  static const String routeEditProfile = '/edit_profile';
  ///#endregion

  /// App route observer
  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver<Route<dynamic>>();

  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get app context
  BuildContext? get appContext => navigatorKey.currentContext;

  /// Generate route for app here
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case routeLayoutState:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => PLayoutState()
        );
      case routeCollectionGrid:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => PCollectionGrid()
        );
      case routeFetchData:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => PTickets()
        );
      case routeDataMutations:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => PProfile()
        );
      case routeEditProfile:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => PEditProfile()
        );
      case routeSignup:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => PSignUp()
        );
      case routeHome:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const HomePage()
        );
      default:
        return null;
    }
  }
}

extension AppRouteExtension on BuildContext {
  AppRoute route() {
    return Provider.of<AppRoute>(this, listen: false);
  }

  NavigatorState? navigator() {
    return route().navigatorKey.currentState;
  }
}
