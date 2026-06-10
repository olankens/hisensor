<div align="center">
  <p><img src=".assets/icon.png" align="center" width="112"></p>
  <h1><samp>SENCHARD</samp></h1>
</div>

<table><tr><td align="center" width="99999"><p>
  <a href="https://olankens.com">WEBSITE</a> ·
  <a href="https://ko-fi.com/olankens">FUNDING</a>
</p></td></tr></table>

<table><tr><td align="center" width="99999">&nbsp;<p>
  Dart library for Hisense U7QF TV to very fully automate picture profile setup process for SDR, HDR10, HDR+, and Dolby Vision content via a reverse engineered MQTT client with a reliable dummy certificate that can bypass broker authentication.
</p>&nbsp;</td></tr></table>

### MATRICES

<table>
  <tbody><tr>
    <td align="center" width="99999"><code>AND</code></td>
    <td align="center" width="99999"><code>IOS</code></td>
    <td align="center" width="99999"><code>LIN</code></td>
    <td align="center" width="99999"><code>MAC</code></td>
    <td align="center" width="99999"><code>WIN</code></td>
    <td align="center" width="99999"><code>WEB</code></td>
  </tr></tbody>
  <tbody><tr>
    <td align="center" height="64"><p>✅</p></td>
    <td align="center"><p>✅</p></td>
    <td align="center"><p>✅</p></td>
    <td align="center"><p>✅</p></td>
    <td align="center"><p>✅</p></td>
    <td align="center"><p>❌</p></td>
  </tr></tbody>
</table>

### FEATURES

<table>
  <tbody><tr><td width="99999">Attach local television</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Bridge with pairing code</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change television source</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Detach local television</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Gather source inputs</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Launch key codes</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change adaptive contrast</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change apply picture</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change backlight</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change brightness</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change color gamut</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change color temperature</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change color saturation</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change contrast</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change gamma adjustment</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change HDMI format</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change local dimming</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change noise reduction</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change picture mode</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change sharpness</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change ultra smooth motion</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Change white balance</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Handle consumption alert</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Revert picture mode</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Revert white balance</td><td align="center">✅</td></tr></tbody>
  <tbody><tr><td>Toggle view angle feature</td><td align="center">✅</td></tr></tbody>
</table>

### LEARNING

#### Importing Package

```sh
flutter pub add senchard --git-url https://github.com/olankens/senchard
```

#### Changing Current Mode

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