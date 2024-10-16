import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/di/di.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_bloc.dart';
import 'package:windmill_digital_poc/presentation/pages/cryptocurrency_detail_page.dart';
import 'package:windmill_digital_poc/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CryptocurrencyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ManageFavoriteBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LoadFavoritesBloc>(),
        ),
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
      title: Strings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardTheme: AppThemes.cardTheme,
        textTheme: const TextTheme(
          titleLarge: AppTextStyles.titleStyle,
          titleMedium: AppTextStyles.subtitleStyle,
        ),
      ),
      initialRoute: Strings.routeHome,
      routes: {
        Strings.routeHome: (context) => const HomePage(),
        Strings.routeDetails: (context) => const CryptocurrencyDetailPage(),
      },
    );
  }
}
