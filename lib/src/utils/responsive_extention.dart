import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';

extension ResponsiveExtension on num {
  // Dimensions - avec facteur web
  double get rh => kIsWeb ? h * 1.2 : h;
  double get rw => kIsWeb ? w  : w;
  
  // Texte & Icons - maintenir la lisibilité
  double get rsp => kIsWeb ? sp  : sp; // Pas de modification
  
  // Radius - proportionnel aux dimensions
  double get rr => kIsWeb ? r * 0.8 : r;
}