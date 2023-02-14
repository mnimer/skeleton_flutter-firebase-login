import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_collections/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  static String get routeName => 'home';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return SizedBox.expand(
      child: Column(
        children: [
          const Text('Home Page'),
          Text(user?.email ?? 'unknown'),
          OutlinedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("logout"))
        ],
      ),
    );
  }
}
