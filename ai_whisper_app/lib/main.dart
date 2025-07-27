import 'package:ai_whisper_app/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home/home_page.dart';
import 'views/prediction/prediction_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AiWhisper',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/predict': (context) => const PredictPage(),
      },
    );
  }
}
