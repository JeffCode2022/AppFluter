
import 'package:flutter/material.dart';

class MyColors {
  //----primary
  static const Color primary = Color(0xFF4B68FF);

  static const Color primaryColor = Color(0xFFE70D32);
  static const Color white = Color(0xFFFFFFFF);

//---------text-------------

  static const Color grey = Color(0xFFA1A1A1);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFE5E5E5);
  static const Color lightBlack = Color(0xFF333333);
  static const Color lightWhite = Color(0xFFE5E5E5);
  static const Color lightRed = Color(0xFFE70D32);
  static const Color lightGreen = Color(0xFF00B761);
  static const Color lightBlue = Color(0xFF00B0FF);
  static const Color lightYellow = Color(0xFFE7B800);
  static const Color lightOrange = Color(0xFFE78C00);

  /// --------- input label

  static const Color inputLabel = Color(0xFFA1A1A1);
  static const Color inputText = Color(0xFF333333);

//----darkgrey
  static const Color darkerGrey = Color(0xFF707070);
  static const Color darkGrey = Color(0xFFA1A1A1);
  static const Color darkBlack = Color(0xFF333333);

// Degradado Retro Sunset
static const Gradient retroSunset = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFFF5F6D),
    Color(0xFFFFC371),
  ],
);

// Degradado Retro Neon
static const Gradient retroNeon = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF8A2BE2),
    Color(0xFF4B0082),
    Color(0xFF9370DB),
  ],
);

// Degradado Moderno Azul
static const Gradient modernBlue = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF4A90E2),
    Color(0xFF2E63BC),
  ],
);

// Degradado Gris Frío
static const Gradient coldGrey = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF404040),
    Color(0xFF777777),
  ],
);

// Degradado Gris Cálido
static const Gradient warmGrey = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF7F7F7F),
    Color(0xFFBFBFBF),
  ],
);

// Degradado Gris Oscuro
static const Gradient darkGrey3 = RadialGradient(
  center: Alignment(0.0, -0.5),
  radius: 1.0,
  colors: [
    Color(0xFF333333),
    Color(0xFF555555),
    Color(0xFF777777),
  ],
);

// Degradado Gris Claro
static const Gradient lightGrey2 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFD3D3D3),
    Color(0xFFEEEEEE),
    Color(0xFFF5F5F5),
  ],
);
// Degradado Moderno Naranja
static const Gradient modernOrange = RadialGradient(
  center: Alignment(0.0, -0.5),
  radius: 1.0,
  colors: [
    Color(0xFFFF9F43),
    Color(0xFFFFBB52),
    Color(0xFFFFD580),
  ],
);

//----dark

  static const Color dark = Color(0xFF000000);
//App Basic Colors
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFB0C7FF);
  static const Color sec = Color(0xFF5E17EB);
  static const Color secundaryColor = Color(0xFFE70D32);



}
