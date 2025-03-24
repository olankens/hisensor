# <samp>OVERVIEW</samp>

Reverse engineered MQTT client for Hisense TVs.
Uses a certificate and private key to bypass broker authentication.

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

### Import the library

```shell
flutter pub add hisensor --git-url https://github.com/olankens/hisensor
```

### Change current picture mode

Sadly, there is no way to determine the current mode.

```dart
var client = Client('television_ip_address_here', foolish: true);
await client.attach();
await client.changePictureMode(PictureMode.cinemaNight);
await client.revertPictureMode();
await client.changeApplyPicture(ApplyPicture.all);
await client.changeLocalDimming(LocalDimming.off);
await client.changeBacklight(40);
await client.changeBrightness(50);
await client.changeContrast(70);
await client.changeColorSaturation(50);
await client.changeSharpness(5);
await client.changeAdaptiveContrast(AdaptiveContrast.off);
await client.changeUltraSmoothMotion(UltraSmoothMotion.off);
await client.changeNoiseReduction(NoiseReduction.off);
await client.changeColorTemperature(ColorTemperature.warm1);
await client.changeColorGamut(ColorGamut.native);
await client.changeGammaAdjustment(GammaAdjustment.gamma22);
await client.toggleViewingAngle();
await client.detach();
```
