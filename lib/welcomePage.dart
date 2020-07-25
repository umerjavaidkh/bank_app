import 'package:abc_bank_app/local_auth_custom.dart';
import 'package:abc_bank_app/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io';
import 'ListPage.dart';
import 'Widget/EnterExitRoute.dart';
import 'Widget/SlideRightRoute.dart';
import 'loginPage.dart';


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  State<StatefulWidget> createState() {

    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin{



   final _auth = LocalAuthenticationOne();

   final  faceGifPath= "assets/gifs/face.gif";

   final  fingerGifPath= "assets/gifs/finger.gif";

   final  double faceAnimFrames = 146;
   final  double fingerAnimFrames = 50;
   final  int faceAnimduration = 5000;
   final  int faceAnimdurationStop = 4000;
   final  int fingerAnimduration = 2500;
   final  int fingerAnimdurationStop = 2500;

   double animFrames = 146;
   int    animDuration = 0;
   int    animDurationStop = 0;
   String mGifPath= "assets/gifs/face.gif";


   GifController controller;

   @override
  void initState() {

     controller= GifController(vsync: this);


  }

   @override
   void dispose() {
     controller.dispose();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {

  //new Image(image: new AssetImage("assets/ajax-loader.gif"))

    return Scaffold(
      body:

      Stack(
          children: <Widget>[

      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffffffff), Color(0xff6573d0)])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                SizedBox(
                  height: 80,
                ),
                _submitButton(),
                SizedBox(
                  height: 20,
                ),
                _signUpButton(),
                SizedBox(
                  height: 20,
                ),
                _label()
              ],
            )),
      ),

     if(isAuthenticated) Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff000000),
        child: Center (
          child:
          GifImage(
         controller: controller,
         image: AssetImage(mGifPath),
         )

        ),
      )

    ]));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'A',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'B',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            TextSpan(
              text: 'C B',
              style: TextStyle(color: Color(0xff6573d0), fontSize: 30),
            ),
            TextSpan(
              text: 'A',
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            TextSpan(
              text: 'N',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            TextSpan(
              text: 'K',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ]),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {

            //Navigator.push(context,
            //EnterExitRoute(exitPage: WelcomePage(), enterPage: LoginPage()));Navigator

           Navigator.push(context, SlideRightRoute(page: LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff6573d0).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xff6573d0)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));*/
        Navigator.push(context, SlideRightRoute(page: SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }




  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with\n Touch ID and Face ID',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
        Builder(
          builder: (context) =>
            Center(
              child: InkWell(
              onTap: () async{

                var bool=await authenticate();

                if(bool){

                var availableBiometrics = await _auth.getAvailableBiometrics();

                availableBiometrics.add(BiometricType.face);

                if(availableBiometrics.contains(BiometricType.face)){
                   isFaceIdCheck=true;
                    mGifPath=faceGifPath;
                    animFrames = faceAnimFrames;
                    animDuration = faceAnimduration;
                    animDurationStop = faceAnimdurationStop;
                  }else{

                   isFaceIdCheck=false;
                   mGifPath=fingerGifPath;
                   animFrames = fingerAnimFrames;
                   animDuration = fingerAnimduration;
                   animDurationStop = fingerAnimdurationStop;
                  }

                  setState(() {
                    isAuthenticated=bool;
                    controller.value=0;
                    controller.repeat(min:0,max:animFrames,period:Duration(milliseconds:animDuration));

                  });

                  Future.delayed( Duration(milliseconds: animDurationStop), () {
                    setState(() {
                      isAuthenticated=false;
                      //controller.reset();
                      controller.stop();
                      Navigator.push(context, SlideRightRoute(page: ListPage()));
                    });

                  });
                }else{
                  _showSnackBar(context,"Not Authorized");
                }

                },
              child : Container(
                child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.fingerprint,
                                    size: 90, color: Colors.white),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Touch ID',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                      "assets/icons/ic_face_id.png",
                                      height: 80, width: 65),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Face ID',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ]),
              ),
              ),
            ),
        ),
          ],
        ));
  }



  bool isAuthenticated = false;

  bool isFaceIdCheck = false;

  Future<bool> authenticate() async {
   bool _isAuthenticated =false;
    try {
      _isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: 'Authenticate to access',
        useErrorDialogs: false,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    return _isAuthenticated;
  }

  void _showSnackBar(BuildContext context, String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        /*action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),*/
      ),
    );
  }
}
