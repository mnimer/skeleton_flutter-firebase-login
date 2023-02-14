import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_collections/firebase_options.dart';
import 'package:list_collections/router.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MyApp()));
}

/// Starting Root Widget
class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      restorationScopeId: 'list_app',
      title: "My Lists",
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
          dividerColor: Colors.black12,
          scaffoldBackgroundColor: Colors.white70,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black.withOpacity(.7),
                displayColor: Colors.black.withOpacity(.7),
              )),
    );
  }
}
