
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/widgets/animated_text_widget.dart';

void main() {
  testWidgets('AnimatedTextWidget renders correctly with given properties', (WidgetTester tester) async {
    
    const givenText = 'Kevych Solutions';
    const givenColor = Colors.red;
    const givenFontSize = 24.0;
    const givenFontStyle = FontStyle.italic;
    const givenFontWeight = FontWeight.bold;

    await tester.pumpWidget(
      const MaterialApp(
        home: AnimatedTextWidget(
          text: givenText,
          color: givenColor,
          fontSize: givenFontSize,
          fontStyle: givenFontStyle,
          fontWeight: givenFontWeight,
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 2));

    final textFinder = find.text(givenText);
    expect(textFinder, findsOneWidget);

    Text textWidget = tester.firstWidget(textFinder) as Text;
    TextStyle? textStyle = textWidget.style;

    expect(textStyle!.color, givenColor);
    expect(textStyle.fontSize, givenFontSize);
    expect(textStyle.fontStyle, givenFontStyle);
    expect(textStyle.fontWeight, givenFontWeight);
  });
}
