import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Front/signup.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height*0.08,),

                Center(
                  child: Lottie.asset('asset/animation.json'),
                ),
                const Text(
                  "Welcome to skill swap & start exchanging",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
              height: height * 0.07,
            ),
                const Text(
                  "Discover,Connect,Exchange skills effortlessly",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                
                SizedBox(
                  height: height * 0.07,
                ),
                Row(
                  children: [
                    Button("Sign in",Color(0XFF2E307A), Colors.white, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignInPage()));
                    }),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Button("Sign Up", Colors.white, Color(0XFF2E307A), () {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpPage()));
                    }),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Explore as a guest",
                    style: TextStyle( color: Color(0XFF2E307A),fontSize: 17),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class Button extends StatelessWidget {
  final String text;
  final Color btnclr;
  final Color textclr;
  final void Function() click;
  Button(this.text, this.textclr, this.btnclr, this.click, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: click,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set border radius
          ),
        ),
        minimumSize: MaterialStateProperty.all(
            Size(width * 0.45, height * 0.07)), // Set width and height
        backgroundColor:
            MaterialStateProperty.all<Color>(btnclr), // Set color to red
      ),
      child: Text(
        text,
        style: TextStyle(color: textclr),
      ),
    );
  }
}
