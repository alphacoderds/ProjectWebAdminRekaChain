import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Inisialisasi nilai untuk data dan nip
    final String nip = '';
    final DataModel data = DataModel(
      kode_staff: '',
      nama: '',
      jabatan: '',
      unit_kerja: '',
      departemen: '',
      divisi: '',
      email: '',
      nip: '',
      noTelp: '',
      status: '',
      password: '',
      konfirmasi_password: '');

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp1(data: data, nip: nip));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}