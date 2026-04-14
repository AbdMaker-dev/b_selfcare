import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';

extension ResponsiveExtension on num {
  // Dimensions - avec facteur web
  double get rh => kIsWeb ? h * 0.84 : h;
  double get rw => kIsWeb ? w * 0.84 : w;
  
  // Texte & Icons - maintenir la lisibilité
  double get rsp => kIsWeb ? sp * 0.85 : sp; // Pas de modification
  
  // Radius - proportionnel aux dimensions
  double get rr => kIsWeb ? r * 0.85 : r;
}