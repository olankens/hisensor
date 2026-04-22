import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:hisensor/hisensor.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Client {
  /// ...
  Client(this.address, {this.foolish = false, this.logging = false}) {
    manager = MqttServerClient.withPort(address, clientIdentifier, port);
    manager.logging(on: logging);
    manager.secure = true;
    manager.setProtocolV311();
  }

  /// ...
  final String address;

  /// ...
  final bool foolish;

  /// ...
  final bool logging;

  /// ...
  final String clientIdentifier = 'hisensor';

  /// ...
  final String macaddr = 'XX:XX:XX:XX:XX:XY';

  /// ...
  late final MqttServerClient manager;

  /// ...
  final String password = 'multimqttservice';

  /// ...
  final int port = 36669;

  /// ...
  final String username = 'hisenseservice';

  /// ...
  Future<bool> attach() async {
    if (foolish) {
      manager.onBadCertificate = (dynamic a) => true;
      final context = SecurityContext.defaultContext;
      const baseUri = 'packages/hisensor/lib/assets';
      context.useCertificateChainBytes((await rootBundle.load('$baseUri/rcm_certchain_pem.cer')).buffer.asInt8List());
      context.usePrivateKeyBytes((await rootBundle.load('$baseUri/rcm_pem_privkey.pkcs8')).buffer.asInt8List());
      manager.securityContext = context;
    }
    await manager.connect(username, password);
    manager.subscribe('/remoteapp/mobile/$macaddr\$normal/#', MqttQos.atMostOnce);
    var correct = true;
    manager.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) => correct = false);
    await invoke('ui_service', 'gettvstate', '');
    await Future.delayed(const Duration(milliseconds: 500));
    return correct;
  }

  /// ...
  Future<bool> bridge(String pairing) async {
    var correct = false;
    manager.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final message = c[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      correct = const JsonDecoder().convert(payload)['result'] == 1;
    });
    await invoke('ui_service', 'authenticationcode', '{"authNum": $pairing}');
    await Future.delayed(const Duration(milliseconds: 2000));
    return correct;
  }

  /// ...
  Future<void> change(String pattern) async {
    var results = await inputs();
    var content = results?.firstWhereOrNull((i) => i['sourcename'].contains(pattern));
    if (content == null) return;
    var element = content['sourceid'].toString();
    var channel = '/remoteapp/tv/ui_service/$macaddr\$normal/actions/changesource';
    var message = MqttClientPayloadBuilder().addString('{"sourceid": $element}');
    manager.publishMessage(channel, MqttQos.exactlyOnce, message.payload!);
    await Future.delayed(const Duration(seconds: 2));
  }

  /// ...
  Future<void> detach() async {
    await Future.delayed(const Duration(milliseconds: 500));
    manager.disconnect();
  }

  /// ...
  Future<List<Map>?> inputs() async {
    List<Map>? inputs;
    manager.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final message = c[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      inputs = List<Map>.from(json.decode(payload).map((x) => x));
    });
    await invoke('ui_service', 'sourcelist');
    return inputs;
  }

  /// ...
  Future<void> invoke(String service, String process, [String payload = '']) async {
    var message = MqttClientPayloadBuilder().addString(payload).payload!;
    var channel = '/remoteapp/tv/$service/$macaddr\$normal/actions/$process';
    manager.publishMessage(channel, MqttQos.exactlyOnce, message);
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// ...
  Future<void> modify(String mission, int section, dynamic content, String variety) async {
    final changed = content.runtimeType == String ? '"$content"' : content;
    final payload = '{"action": "$mission", "menu_id": $section, "menu_value": $changed, "menu_value_type": "$variety"}';
    await invoke('platform_service', 'picturesetting', payload);
  }

  /// ...
  Future<void> repeat(String keycode, {int repeats = 1}) async {
    for (int i = 0; i < repeats; i++) {
      await invoke('remote_service', 'sendkey', keycode.toUpperCase());
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  /// ...
  Future<void> changeAdaptiveContrast(AdaptiveContrast payload) async {
    await modify('set_value', 29, payload.value, 'int');
  }

  /// ...
  Future<void> changeApplyPicture(ApplyPicture payload) async {
    await modify('set_value', 85, payload.value, 'int');
  }

  /// ...
  Future<void> changeBacklight(int payload) async {
    await modify('set_value', 8, payload, 'int');
  }

  /// ...
  Future<void> changeBrightness(int payload) async {
    await modify('set_value', 3, payload, 'int');
  }

  /// ...
  Future<void> changeColorGamut(ColorGamut payload) async {
    await modify('set_value', 52, payload.value, 'int');
  }

  /// ...
  Future<void> changeColorTemperature(ColorTemperature payload) async {
    await modify('set_value', 30, payload.value, 'int');
  }

  /// ...
  Future<void> changeColorSaturation(int payload) async {
    await modify('set_value', 5, payload, 'int');
  }

  /// ...
  Future<void> changeContrast(int payload) async {
    await modify('set_value', 4, payload, 'int');
  }

  /// ...
  Future<void> changeGameMode(bool enabled) async {
    await modify('set_value', 122, enabled ? 1 : 0, 'int');
  }

  /// ...
  Future<void> changeGammaAdjustment(GammaAdjustment payload) async {
    await modify('set_value', 77, payload.value, 'int');
  }

  /// ...
  Future<void> changeHdmiFormat(HdmiFormat payload) async {
    await repeat('key_menu');
    await repeat('key_down', repeats: 2);
    await repeat('key_ok');
    await repeat('key_down', repeats: 5);
    await repeat('key_ok');
    await repeat('key_down', repeats: 11);
    await repeat('key_up', repeats: 2);
    await repeat('key_ok', repeats: 2);
    await repeat(payload.value, repeats: 2);
    await repeat('key_ok');
    await Future.delayed(const Duration(seconds: 2));
    await repeat('key_returns', repeats: 5);
  }

  /// ...
  Future<void> changeLocalDimming(LocalDimming payload) async {
    await modify('set_value', 27, payload.value, 'int');
  }

  /// ...
  Future<void> changeNoiseReduction(NoiseReduction payload) async {
    await modify('set_value', 25, payload.value, 'int');
    await modify('set_value', 26, payload.value, 'int');
  }

  /// ...
  Future<void> changePictureMode(PictureMode payload) async {
    await modify('on_action', 1, payload.value, 'string');
  }

  /// ...
  Future<void> changeSharpness(int payload) async {
    await modify('set_value', 21, payload * 2, 'int');
  }

  /// ...
  Future<void> changeUltraSmoothMotion(UltraSmoothMotion payload) async {
    await modify('set_value', 23, payload.value, 'int');
  }

  /// ...
  Future<void> changeWhiteBalance(int rOffset, int gOffset, int bOffset, int rGain, int gGain, int bGain) async {
    await revertWhiteBalance();
    await modify('set_value', 35, rOffset, 'int');
    await modify('set_value', 36, gOffset, 'int');
    await modify('set_value', 37, bOffset, 'int');
    await modify('set_value', 32, rGain, 'int');
    await modify('set_value', 33, gGain, 'int');
    await modify('set_value', 34, bGain, 'int');
  }

  /// ...
  Future<void> handleConsumptionAlert() async {
    await repeat('key_menu');
    await repeat('key_down', repeats: 2);
    await repeat('key_ok');
    await repeat('key_right');
    await repeat('key_ok');
    await repeat('key_returns', repeats: 4);
  }

  /// ...
  Future<void> revertPictureMode() async {
    await modify('on_action', 104, '-1', 'string');
  }

  /// ...
  Future<void> revertWhiteBalance() async {
    await modify('set_value', 43, 0, 'int');
    await modify('on_action', 100, '-1', 'string');
  }

  /// ...
  Future<void> toggleViewingAngle() async {
    await repeat('key_menu');
    await repeat('key_down', repeats: 2);
    await repeat('key_ok', repeats: 2);
    await repeat('key_down', repeats: 5);
    await repeat('key_ok');
    await repeat('key_down', repeats: 20);
    await repeat('key_up', repeats: 2);
    await repeat('key_ok');
    await repeat('key_down', repeats: 10);
    await repeat('key_up');
    await repeat('key_ok');
    await repeat('key_returns', repeats: 5);
  }
}
