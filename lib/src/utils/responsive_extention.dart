import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';

extension ResponsiveExtension on num {
  double get rh {
    if (kIsWeb) {
      final scale = ScreenUtil().scaleHeight.clamp(0.8, 1.0);
      return toDouble() * scale;
    }
    return h;
  }

  double get rw => w;
  double get rr => r;

  // Sur web, on clamp le scale entre 0.8 et 1.0 pour éviter que
  // le zoom navigateur (qui change la viewport) ne grossisse les textes.
  double get rsp {
    if (kIsWeb) {
      final scale = ScreenUtil().scaleWidth.clamp(0.8, 1.0);
      return toDouble() * scale;
    }
    return sp;
  }
}