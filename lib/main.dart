import 'package:csv_to_pdf_transformation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chart_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChartApp());
}

class ChartApp extends StatelessWidget {
  const ChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Home page'),
      ),
    );
  }
}
