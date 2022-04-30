import 'package:flutter/material.dart';
import '/ui/widgets/original_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            Hero(
              tag: 'logoAnimation',
              child: Image.asset(
                'assets/images/lg.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    OriginalButton(
                      text: 'Courses',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pushNamed('home');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    OriginalButton(
                      text: 'Register',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pushNamed('register');
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
