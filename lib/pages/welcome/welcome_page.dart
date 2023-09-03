import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/welcome_page_view_model.dart';
import 'package:flutter_weather_app/widgets/animated_text_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final WelcomePageViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = WelcomePageViewModel(context: context);
   // viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextWidget(
                text: 'K',
                color: Colors.orangeAccent,
                fontSize: 35,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              AnimatedTextWidget(
                text: 'evych Solutions',
                color: Colors.white,
                fontSize: 35,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
