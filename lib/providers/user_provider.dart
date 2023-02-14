import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_collections/auth.dart';

//User? _user;
final userProvider = StateProvider((ref) {
  final user = ref.watch(authProvider);
  if (user.value != null) {
    return FirebaseAuth.instance.currentUser;
  } else {
    return null;
  }
});

/*class UserProvider extends ChangeNotifier {
  final User? user;

  UserProvider(this.user);

  Future<List<Collection>> getUserOwnedCollections() async {
    return [];
  }
}*/
