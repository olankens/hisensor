# <samp>OVERVIEW</samp>

Reverse engineered MQTT client for Hisense TVs that helps you automatically set up picture profiles (SDR, HDR10, HDR+, and DOVI) after each firmware upgrade.

This library uses a [dummy certificate and private key](lib/assets) to bypass broker authentication.

Some TV models may require OTP-based permission.

### Supported Platforms

<table>
  <tr align="center">
    <th><samp>AND</samp></th>
    <th><samp>IOS</samp></th>
    <th><samp>LIN</samp></th>
    <th><samp>MAC</samp></th>
    <th><samp>WIN</samp></th>
    <th><samp>WEB</samp></th>
  </tr>
  <tr align="center" height="50">
    <td width="9999">🟩</td>
    <td width="9999">🟩</td>
    <td width="9999">🟩</td>
    <td width="9999">🟩</td>
    <td width="9999">🟩</td>
    <td width="9999">🟥</td>
  </tr>
</table>

# <samp>GUIDANCE</samp>

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
