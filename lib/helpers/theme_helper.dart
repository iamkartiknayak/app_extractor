import 'package:flutter/material.dart';

class ThemeHelper {
  static Color darkenColor(Color color, double factor) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1.');
    final hsl = HSLColor.fromColor(color);
    final darkenedHsl = hsl.withLightness(
      (hsl.lightness - factor).clamp(0.0, 1.0),
    );
    return darkenedHsl.toColor();
  }
}
