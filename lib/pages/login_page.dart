import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_collections/forms/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String get routeName => 'login';
  static String get routeLocation => '/$routeName';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginModel _model = LoginModel();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = LoginModel(); //createModel(context, () => LoginModel());

    _model.emailAddressController = TextEditingController(text: 'mnimer+1@gmail.com');
    _model.passwordController = TextEditingController(text: 'admin_24601');
    _model.emailAddressCreateController = TextEditingController();
    _model.passwordCreateController = TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void signInWithGoogle() async {
      // Create a new provider
      String? email = _model.emailAddressController?.text;
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': email});

      // Once signed in, return the UserCredential
      final credential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      debugPrint(credential.toString());

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    }

    void signInWithUsernamePassword() async {
      try {
        String? email = _model.emailAddressController?.text;
        String? pwd = _model.passwordController?.text;
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: pwd!);
        debugPrint(credential.toString());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          debugPrint('Wrong password provided for that user.');
        }
      }
    }

    void createUserHandler() async {
      try {
        String? email = _model.emailAddressController?.text;
        String? pwd = _model.passwordController?.text;
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: pwd!,
        );
        debugPrint(credential.toString());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF4B39EF),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unFocusNode),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 60),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My Lists',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamilyFallback: ['Poppins'],
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelPadding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        labelStyle: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: 'Outfit',
                          color: const Color(0xFF0F1113),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        indicatorColor: Colors.white,
                        tabs: const [
                          Tab(
                            text: 'Sign In',
                          ),
                          Tab(
                            text: 'Sign Up',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                                    child: TextFormField(
                                      controller: _model.emailAddressController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter your email...',
                                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                      ),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      minLines: 1,
                                      //validator: _model.emailAddressControllerValidator?.asValidator(context),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                                    child: TextFormField(
                                      controller: _model.passwordController,
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter your password...',
                                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordVisibility = !_model.passwordVisibility,
                                          ),
                                          focusNode: FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: const Color(0xFF57636C),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      minLines: 1,
                                      //validator: _model.passwordControllerValidator.asValidator(context),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                    child: SizedBox(
                                      width: 230,
                                      height: 50,
                                      child: OutlinedButton(
                                        onPressed: () => signInWithUsernamePassword(),
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty.all(1),
                                            backgroundColor: MaterialStateProperty.all(Colors.white)),
                                        child: const Text('Sign In',
                                            style: TextStyle(
                                                color: Color(0xFF4B39EF),
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Outfit',
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                    child: TextButton(
                                      onPressed: () {
                                        debugPrint('Button-ForgotPassword pressed ...');
                                      },
                                      child: const Text('Forgot Password?', style: TextStyle(color: Colors.white)),
                                      /**
                                      options: TextButton(
                                        width: 170,
                                        height: 40,
                                        color: const Color(0xFF4B39EF),
                                        textStyle: theme.textTheme.titleSmall?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        elevation: 0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      **/
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                          child: Text(
                                            'Or use a social account to login',
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              fontFamily: 'Lexend Deca',
                                              color: const Color(0x98FFFFFF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () => signInWithGoogle(),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF0F1113),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x3314181B),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: const AlignmentDirectional(0, 0),
                                            child: const FaIcon(
                                              FontAwesomeIcons.google,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            /***
                                            final _localAuth = LocalAuthentication();
                                            bool _isBiometricSupported = await _localAuth.isDeviceSupported();

                                            if (_isBiometricSupported) {
                                              _model.biometric =
                                                  await _localAuth.authenticate(localizedReason: 'Please authenticate');
                                              setState(() {});
                                            }
                                            **/

                                            if (_model.biometric!) {
                                              /**
                                              GoRouter.of(context).prepareAuthEvent();
                                              final user = await signInWithJwtToken(
                                                context,
                                                currentJwtToken!,
                                              );
                                              if (user == null) {
                                                return;
                                              }

                                              context.pushNamedAuth('collections', mounted);
                                                **/
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Unauthorized Request',
                                                    /**
                                                    style: TextStyle(
                                                      color: theme.textTheme.bodyMedium,
                                                    ), **/
                                                  ),
                                                  duration: Duration(milliseconds: 4000),
                                                  backgroundColor: Color(0x00000000),
                                                ),
                                              );
                                            }

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF0F1113),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x3314181B),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: const AlignmentDirectional(0, 0),
                                            child: const Icon(
                                              Icons.fingerprint,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                                      child: TextFormField(
                                        controller: _model.emailAddressCreateController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                            fontFamily: 'Outfit',
                                            color: const Color(0xFF0F1113),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            //lineHeight: 14,
                                          ),
                                          hintText: 'Enter your email...',
                                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                            fontFamily: 'Outfit',
                                            color: const Color(0xFF0F1113),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                        ),
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF0F1113),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        //validator: _model.emailAddressCreateControllerValidator.asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                                    child: TextFormField(
                                      controller: _model.passwordCreateController,
                                      obscureText: !_model.passwordCreateVisibility,
                                      decoration: InputDecoration(
                                        labelStyle: theme.textTheme.bodySmall?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter your password...',
                                        hintStyle: theme.textTheme.bodySmall?.copyWith(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordCreateVisibility = !_model.passwordCreateVisibility,
                                          ),
                                          focusNode: FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordCreateVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: const Color(0xFF57636C),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      minLines: 1,
                                      //validator: _model.passwordCreateControllerValidator.asValidator(context),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Enable Biometric',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFFFCFCFC),
                                        ),
                                      ),
                                      Switch(
                                        value: _model.switchValue ??= false,
                                        onChanged: (newValue) async {
                                          setState(() => _model.switchValue = newValue!);
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                    child: SizedBox(
                                      width: 230,
                                      height: 50,
                                      child: OutlinedButton(
                                        onPressed: () => createUserHandler(),
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty.all(1),
                                            backgroundColor: MaterialStateProperty.all(Colors.white)),
                                        child: const Text('Create Account',
                                            style: TextStyle(
                                                color: Color(0xFF4B39EF),
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Outfit',
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                          child: Text(
                                            'Sign up using a social account',
                                            style: theme.textTheme.bodyLarge?.copyWith(
                                              fontFamily: 'Lexend Deca',
                                              color: const Color(0x98FFFFFF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            /**
                                            GoRouter.of(context).prepareAuthEvent();
                                            final user = await signInWithGoogle(context);
                                            if (user == null) {
                                              return;
                                            }

                                            context.goNamedAuth('collections', mounted);
                                            **/
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF0F1113),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x3314181B),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: const AlignmentDirectional(0, 0),
                                            child: const FaIcon(
                                              FontAwesomeIcons.google,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
