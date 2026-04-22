<hr>

<div align="center">
  <p><img src=".assets/icon.svg" width="128"/></p>
  <sub>LIBRARY</sub>
  <h1>HISENSOR</h1>
  <p>Automate Hisense TV picture profile setup for SDR, HDR10, HDR+, and Dolby Vision via reverse engineered MQTT client with dummy certificate to bypass broker authentication. Some models need OTP permission.</p>
</div>

<hr>

### Installation

```shell
flutter pub add hisensor --git-url https://github.com/olankens/hisensor
```

<hr>

### Changing Current Mode

There is no way to change the current picture mode, you have to play a specific content for this, it's out of this library scope.

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