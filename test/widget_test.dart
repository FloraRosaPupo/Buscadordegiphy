import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_5/features/gifs/presentation/home_page.dart';

void main() {
  testWidgets('ausência de configuração apresenta erro ao usuário',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();
    expect(find.text('Não foi possível carregar os GIFs.'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
