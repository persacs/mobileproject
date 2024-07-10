import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _isSigningIn
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _isSigningIn = true;
                                });

                                User user =
                                    await Authentication.signInWithGoogle(
                                        context: context);
                                print(user.email);

                                setState(() {
                                  _isSigningIn = false;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image:
                                          AssetImage("assets/google_logo.png"),
                                      height: 35.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Login Google',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    );
                  }

                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
