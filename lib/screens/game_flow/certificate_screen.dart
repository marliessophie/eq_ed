import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CertificateScreen extends StatefulWidget {
  static var id = 'certificate_screen';

  @override
  _CertificateScreenState createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  late ConfettiController controllerTopCenter;
  @override
  void initState() {
    super.initState();
    setState(() {
      initController();
    });
  }

  void initController() {
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade50,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Certificate'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildConfettiWidget(controllerTopCenter, pi / 1),
            buildConfettiWidget(controllerTopCenter, pi / 4),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Container(
                    child: AnimatedImage(),
                    height: 250.0,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    '🤩 Congratulations 🤩',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'You have completed all levels of EQ\'ed! \n'
                    'Time to give yourself a pat on the back. \n'
                    'Tap the button below for some celebratory \n'
                    'action, and feel free to take a Screen \n'
                    'Shot of this certificate. Well done!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 19.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            buildButton()
          ],
        ),
      ),
    );
  }

  Align buildButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: RaisedButton(
          onPressed: () {
            controllerTopCenter.play();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: kPrimaryColor,
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Tap to celebrate!",
              style: kNormalTextStyle.copyWith(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(30, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.directional,
        maxBlastForce: 20, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 1,
        numberOfParticles: 8, // a lot of particles at once
        gravity: 1,
      ),
    );
  }
}
