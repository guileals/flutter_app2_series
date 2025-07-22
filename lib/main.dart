import 'package:flutter/material.dart';
import 'package:flutter_app2_series/base_screen.dart';
import 'package:flutter_app2_series/tv_show_form_screen.dart';
import 'package:flutter_app2_series/custom_drawer.dart';
import 'package:flutter_app2_series/my_theme_model.dart';
import 'package:flutter_app2_series/tv_show_model.dart';
import 'package:flutter_app2_series/tv_show_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => TvShowModel(),
    //   child: const MainApp(),
    // ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TvShowModel()),
        ChangeNotifierProvider(create: (context) => MyThemeModel()),
      ],
      child: const MainApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => TvShowScreen()),
        GoRoute(path: '/add', builder: (context, state) => TvShowFormScreen()),
        GoRoute(
          path: '/edit/:index',
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index']!);
            return TvShowFormScreen(
              tvShow: context.read<TvShowModel>().tvShows[index],
            );
          },
        ),
      ],
    ),
  ],
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: context.read<MyThemeModel>().customTheme,
      darkTheme: context.read<MyThemeModel>().customThemeDark,
      themeMode: context.watch<MyThemeModel>().isDark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
