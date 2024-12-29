import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width * 1,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  top: -40,
                  right: 20,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: kPrimaryColor2.withOpacity(.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Login',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor2),
          ),
          Image.asset(
            AssetsData.imageOne,
            height: 330,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  fillColor: kPrimaryColor2.withOpacity(.2),
                  filled: true,
                  hintText: 'Phone Number ',
                  hintStyle: const TextStyle(
                    color: kPrimaryColor2,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: GestureDetector(
              child: Container(
                height: 60,
                // width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                  color: kPrimaryColor2,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            'Or Login with',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: kPrimaryColor2,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/facebook.png',
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/new.png',
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/twitter.png',
                  height: 50,
                ),
              ],
            ),
          ),
          const Text(
            "Don't have an account ? Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: kPrimaryColor2,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 41,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  bottom: -60,
                  left: 20,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: kPrimaryColor2.withOpacity(.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
