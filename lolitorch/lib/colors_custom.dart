import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE4E5E8),
  100: Color(0xFFBBBFC6),
  200: Color(0xFF8D95A0),
  300: Color(0xFF5F6A7A),
  400: Color(0xFF3D4A5E),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF18253B),
  700: Color(0xFF141F32),
  800: Color(0xFF10192A),
  900: Color(0xFF080F1C),
});
const int _primaryPrimaryValue = 0xFF1B2A41;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFF5C8AFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF0046F5),
  700: Color(0xFF003FDB),
});
const int _primaryAccentValue = 0xFF2966FF;