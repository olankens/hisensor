<hr>

# OVERVIEW

Reverse engineered MQTT client for Hisense TVs that helps you automatically set up picture profiles (SDR, HDR10, HDR+, and DOVI) after each firmware upgrade. This library uses a [dummy certificate and private key](lib/assets) to bypass broker authentication. Some TV models may require OTP-based permission.

<hr>

# GUIDANCE

### Import Library

```shell
flutter pub add hisensor --git-url https://github.com/olankens/hisensor
```

### Change Current Mode

```dart
var client = Client('television_ip_address_here', foolish: true);
await client.attach();
await client
  ..changePictureMode(PictureMode.cinemaNight)
  ..revertPictureMode()
  ..changeApplyPicture(ApplyPicture.all)
  ..changeLocalDimming(LocalDimming.off)
  ..changeBacklight(40)
  ..changeBrightness(50)
  ..changeContrast(70)
  ..changeColorSaturation(50)
  ..changeSharpness(5)
  ..changeAdaptiveContrast(AdaptiveContrast.off)
  ..changeUltraSmoothMotion(UltraSmoothMotion.off)
  ..changeNoiseReduction(NoiseReduction.off)
  ..changeColorTemperature(ColorTemperature.warm1)
  ..changeColorGamut(ColorGamut.native)
  ..changeGammaAdjustment(GammaAdjustment.gamma22)
  ..toggleViewingAngle();
await client.detach();
```

<hr>
