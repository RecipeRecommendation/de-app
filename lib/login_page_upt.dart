import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:de_app/signUp.dart';
import 'package:sizer/sizer.dart';

void main(){
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      )
  );
}

class LoginPage extends StatefulWidget {


  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isAnimating = true;
  ButtonState state = ButtonState.init;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    final buttonWidth = MediaQuery.of(context).size.width;
    final isStretched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              RawMaterialButton(
                onPressed: () => print(MediaQuery.of(context).viewInsets.bottom.toString()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: SizedBox.fromSize(
                    child: Image.asset(
                      "assets/images/loginImage.jpg",
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: SizedBox(
                        height: 100.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 45.0,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade800,
                              ),
                              child: AnimatedTextKit(
                                pause: const Duration(milliseconds: 700),
                                repeatForever: true,
                                animatedTexts: [
                                  RotateAnimatedText('नमस्ते',
                                      textStyle: const TextStyle(fontSize: 50.0)),
                                  RotateAnimatedText('Welcome'),
                                  RotateAnimatedText('શુભેચ્છા',
                                      textStyle: const TextStyle(fontSize: 50.0)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                leading: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.blueGrey.shade800,
                                  ),
                                ),
                                title: TextField(
                                  // keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Username',
                                    hintText: 'Enter your Username!',
                                    labelStyle: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 35.0, vertical: 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                leading: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon(
                                    Icons.password_rounded,
                                    color: Colors.blueGrey.shade800,
                                  ),
                                ),
                                title: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Password',
                                      // hintText: 'Enter your Password!',
                                      labelStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.normal)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() => OutlinedButton(
    onPressed: signIn,
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      side: const BorderSide(
        width: 2,
        color: Colors.deepOrange,
      ),
    ),
    child: const FittedBox(
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 30.0,
          fontFamily: 'WorkSans',
          color: Colors.deepOrange,
        ),
      ),
    ),
  );

  Future signIn() async {
    setState(() {
      state = ButtonState.loading;
    });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      state = ButtonState.done;
    });
    await Future.delayed(const Duration(seconds: 2));
  }

  Widget buildSmallProcessingButton(bool isDone) {
    final color = isDone ? const Color(0xFF449C69) : Colors.deepOrange;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: isDone
            ? const Icon(
          Icons.done,
          size: 52,
          color: Colors.white,
        )
            : const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

}
