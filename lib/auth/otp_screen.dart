import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/auth/login_page.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  final bool isSignUp;
  bool isDoctor;
  MyVerify({Key? key, required this.isSignUp, required this.isDoctor})
      : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  @override
  Widget build(BuildContext context) {
    String countrycode = '+91';
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 149, 149, 149)),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = '';
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
            ])),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.white38,
                      ),
                    ),
                    child: Image.asset(
                      'assets/College.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(height: 50),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          const SizedBox(height: 30),
                          const Text(
                            "Phone OTP Verification",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          Pinput(
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            onChanged: (value) {
                              code = value;
                            },
                            length: 6,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: LoginPage.verify,
                                          smsCode: code);
                                  if (widget.isSignUp) {
                                    if (widget.isDoctor) {
                                      await auth
                                          .signInWithCredential(credential);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          'd_details', (route) => false);
                                    } else {
                                      await auth
                                          .signInWithCredential(credential);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          'm_details', (route) => false);
                                    }
                                  } else {
                                    if (widget.isDoctor) {
                                      await auth
                                          .signInWithCredential(credential);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          'd_initial', (route) => false);
                                    } else {
                                      await auth
                                          .signInWithCredential(credential);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          'm_initial', (route) => false);
                                    }
                                    // ignore: empty_catches
                                  }
                                } catch (e) {}
                                ;
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 50),
                                  backgroundColor:
                                      const Color.fromARGB(255, 16, 89, 149)),
                              child: const Text(
                                'Verify Mobile Number',
                                style: TextStyle(fontSize: 20),
                              )),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Edit Phone Number ?",
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          )
                        ]),
                      )),
                ))
              ],
            )),
      ),
    );
  }
}
