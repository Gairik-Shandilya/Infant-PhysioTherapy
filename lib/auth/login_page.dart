import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/auth/otp_screen.dart';
import 'package:physiotherapy/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String verify = '';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobilenoController = TextEditingController();
  final otpController = TextEditingController();
  var phone = '';
  String countrycode = '+91';

  @override
  Widget build(BuildContext context) {
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
                  height: 45,
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
                const SizedBox(height: 45),
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
                          const Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4A545E),
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 275,
                            child: const Text(
                              "Please Enter Your 10 - Digit Mobile Number To Recieve OTP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                phone = value;
                              },
                              controller: mobilenoController,
                              obscureText: false, //hide password
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mobile_screen_share,
                                    color: Colors.grey.shade600,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Color(0xFF4C4C4C))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                  )),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: "Mobile Number",
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(90, 0, 0, 0))
                                  //to hint what is written in text field
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: '${phone}',
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    LoginPage.verify = verificationId;
                                    Navigator.pushNamed(context, 'otp');
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 50),
                                  backgroundColor:
                                      const Color.fromARGB(255, 16, 89, 149)),
                              child: const Text(
                                'Request OTP',
                                style: TextStyle(fontSize: 20),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Do not have an account yet ? ',
                                style: TextStyle(
                                  color: Color(0xFF4A545E),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 225, 165, 14),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
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
