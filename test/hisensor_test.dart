import 'package:flutter_test/flutter_test.dart';
import 'package:hisensor/hisensor.dart';
import 'package:hisensor/src/client.dart';

late final Client hisense;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    hisense = Client('192.168.1.60', foolish: true);
    await hisense.attach();
  });

  tearDownAll(() async {
    await hisense.detach();
  });

  test('change()', () async {
    await hisense.change('2');
    await hisense.change('3');
  });

  test('repeat()', () async {
    await hisense.repeat('key_menu');
  });
}
