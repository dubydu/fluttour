import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

mixin DynamicSize {
  /// https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
  ///    iPhone 2, 3, 4, 4s                => 3.5": 320 x 480 (points)
  ///    iPhone 5, 5s, 5C, SE (1st Gen)    => 4": 320 × 568 (points)
  ///    iPhone 6, 6s, 7, 8, SE (2st Gen)  => 4.7": 375 x 667 (points)
  ///    iPhone 6+, 6s+, 7+, 8+            => 5.5": 414 x 736 (points)
  ///    iPhone 11Pro, X, Xs               => 5.8": 375 x 812 (points)
  ///    iPhone 11, Xr                     => 6.1": 414 × 896 (points)
  ///    iPhone 11Pro Max, Xs Max          => 6.5": 414 x 896 (points)
  ///    iPhone 12 mini                    => 5.4": 375 x 812 (points)
  ///    iPhone 12, 12 Pro                 => 6.1": 390 x 844 (points)
  ///    iPhone 12 Pro Max                 => 6.7": 428 x 926 (points)
  void initDynamicSize(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
  }
}
