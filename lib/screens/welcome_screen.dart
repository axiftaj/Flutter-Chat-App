import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {

  static const String id = 'welcome_screen' ;
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  final _auth  = FirebaseAuth.instance ;
  FirebaseUser logedInUser ;

  AnimationController controller;
  Animation animation ;

  //this mehtods called when this LoginScreen is created not hit hte build
  @override
  void initState() {
    // TODO: implement
    //  initState
    super.initState();

    getCurrentUser() ;
    controller = AnimationController(
      duration: Duration(seconds:  3), // this will set the time of animation how long your animation will takes place
      vsync: this, //this is the tricker provide it is going to be state ibject
      // we set the upper bound to 100 custom values and build the animation
    );

    //Tween animation
    animation = ColorTween(begin: Colors.red , end: Colors.blue ).animate(controller);

    //curved animation
    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn); // if you are using CurvedAnimation make sure the upper bound must be 1

    //this method is to check the status and user for reverse and forward animation
//    animation.addStatusListener((status) {
//      //this will create the loop
//      if(status == AnimationStatus.completed){
//        controller.reverse(from: 1);
//      }else if(status == AnimationStatus.dismissed){
//        controller.forward();
//      }
//    });
    //controller.forward(); // this moves forward from 0 to 1 in 60 steps
    controller.reverse(from : 1.0); //now it will reverse this from 100 t0 1
    controller.addListener(() {
      setState(() {
      });
    });

  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        logedInUser = user;
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // this will changes the obacity from 0 to 1 in using color.red.withOpacity taking controller values
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height:60, //controller.value this will increae the avalue from 0 to 100 and cause the animation
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],// '${controller.value.toInt()}%' showing upper bound values
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(
            title: 'Register',
            colour: Colors.blueAccent,
            onPressed: (){
            Navigator.pushNamed(context, RegistrationScreen.id);
            },
            ),
          ],
        ),
      ),
    );
  }
}
