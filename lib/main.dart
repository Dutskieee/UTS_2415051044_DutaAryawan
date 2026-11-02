import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/travel_provider.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fjxvhqdpyufulvvvxkzt.supabase.co',
    anonKey: 'sb_publishable_AiCpVJBkCsBi6N2W3L8tWg_fZwZ5FCl',
  );
print('✅ BERHASIL: Supabase sudah terkoneksi dengan mantap!');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TravelProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
