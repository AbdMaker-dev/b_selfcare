import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';

extension ResponsiveExtension on double {
  // Dimensions - avec facteur web
  double get rh => kIsWeb ? h * 0.85 : h;
  double get rw => kIsWeb ? w * 0.85 : w;
  
  // Texte & Icons - maintenir la lisibilité
  double get rsp => kIsWeb ? sp * 0.8 : sp; // Pas de modification
  
  // Radius - proportionnel aux dimensions
  double get rr => kIsWeb ? r * 0.8 : r;
}