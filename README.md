# <samp>OVERVIEW</samp>

Reversed MQTT client for Hisense TVs.

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

Helps me setting up my picture profiles (SDR, HDR10, HDR+ and DOVI) after each firmware upgrade. It uses dummy certificate and private key to foolish the broker authentication, some TV models require permission via OTP. It's an extremely naive solution, do not use it in production.

# <samp>GUIDANCE</samp>

### Import library

```shell
flutter pub add hisensor --git-url https://github.com/olankens/hisensor
```

### Change current mode

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
