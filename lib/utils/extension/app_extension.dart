
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extension for screen util
extension SizeExtension on num {
  /// setWidth
  double get W => w.toDouble();

  /// setHeight
  double get H => h.toDouble();

  /// Set sp with default allowFontScalingSelf = false
  /// ignore: non_constant_identifier_names
  double get SP => sp.toDouble();

  /// Set sp with allowFontScalingSelf: true
  /// ignore: non_constant_identifier_names
  double get SSP => ssp.toDouble();

  /// Set sp with allowFontScalingSelf: false
  /// ignore: non_constant_identifier_names
  double get NSP => nsp.toDouble();

  /// % of screen width
  /// ignore: non_constant_identifier_names
  double get SW => sw.toDouble();

  /// % of screen height
  /// ignore: non_constant_identifier_names
  double get SH => sh.toDouble();
}