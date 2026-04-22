enum AdaptiveContrast {
  off(0),
  low(1),
  medium(2),
  high(3),
  ;

  const AdaptiveContrast(this.value);

  final int value;
}

enum ApplyPicture {
  current(0),
  all(1),
  ;

  const ApplyPicture(this.value);

  final int value;
}

enum ColorGamut {
  auto(0),
  native(1),
  ;

  const ColorGamut(this.value);

  final int value;
}

enum ColorTemperature {
  standard(1),
  warm1(2),
  warm2(3),
  cool(4),
  ;

  const ColorTemperature(this.value);

  final int value;
}

enum GammaAdjustment {
  bt1886(3),
  gamma18(4),
  gamma19(5),
  gamma20(0),
  gamma21(6),
  gamma22(1),
  gamma23(7),
  gamma24(2),
  gamma26(9),
  ;

  const GammaAdjustment(this.value);

  final int value;
}

enum HdmiFormat {
  standard('KEY_UP'),
  enhanced('KEY_DOWN'),
  ;

  const HdmiFormat(this.value);

  final String value;
}

enum LocalDimming {
  off(0),
  low(1),
  medium(2),
  high(3),
  ;

  const LocalDimming(this.value);

  final int value;
}

enum NoiseReduction {
  off(0),
  low(1),
  medium(2),
  high(3),
  ;

  const NoiseReduction(this.value);

  final int value;
}

enum PictureMode {
  standard('1'),
  cinemaDay('3'),
  cinemaNight('2'),
  dynamic('0'),
  sports('5'),
  hdrStandard('1'),
  hdrDay('3'),
  hdrNight('2'),
  hdrDynamic('0'),
  hdrSports('5'),
  dolbyVisionBright('3'),
  dolbyVisionDark('2'),
  dolbyVisionCustom('1'),
  ;

  const PictureMode(this.value);

  final String value;
}

enum UltraSmoothMotion {
  off(0),
  smooth(5),
  standard(4),
  clear(3),
  film(2),
  ;

  const UltraSmoothMotion(this.value);

  final int value;
}
