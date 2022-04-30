import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CollaborativeRecipeSuggestionPage.dart';
import 'package:de_app/globals.dart' as globals;

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     return const MaterialApp(
//       title: 'Recipe Recommender',
//       home: RandomRecipeSuggestionPage(),
//     );
//   }
// }

enum ButtonState { loading, done }

class RandomRecipeSuggestionPage extends StatefulWidget {
  const RandomRecipeSuggestionPage({Key? key}) : super(key: key);

  @override
  State<RandomRecipeSuggestionPage> createState() =>
      _RandomRecipeSuggestionPageState();
}

class _RandomRecipeSuggestionPageState
    extends State<RandomRecipeSuggestionPage> {
  ButtonState state = ButtonState.loading;

  Map<String, dynamic> output = Map<String, dynamic>.from({});

  void _initialization() async {
    const API_URL = 'http://drumal-37010.portmap.io:37010/recommender/random';

    final response = await http.get(Uri.parse(API_URL));
    Map<String, dynamic> data =
        Map<String, dynamic>.from(jsonDecode(response.body));

    setState(() {
      output = data;
      print(output[output.keys.elementAt(0)]);
    });

    await Future.delayed(const Duration(milliseconds: 3500));

    setState(() {
      state = ButtonState.done;
      print('done');
    });
  }

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDone = state == ButtonState.done;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.grey.shade800,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    'Delicious, Recipes for you!',
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: 'WorkSans',
                        color: Colors.blueGrey.shade800),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 100.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: isDone ? _listOfRecipes() : _loadingPage(),
          ),
        ],
      ),
    );
  }

  Widget _loadingPage() {
    return Column(
      children: [
        Container(
          height: 100.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 43.0,
              fontFamily: 'WorkSans',
              color: const Color(0xFF04005E),
            ),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 500),
              animatedTexts: [
                FadeAnimatedText(
                  'Getting Delicious Recipes For You!',
                  textStyle: const TextStyle(
                    fontSize: 45.0,
                  ),
                  textAlign: TextAlign.center,
                  duration: const Duration(milliseconds: 1500),
                ),
              ],
              repeatForever: true,
            ),
          ),
        ),
        const SizedBox(
          height: 100.0,
        ),
        LoadingBouncingGrid.square(
          backgroundColor: const Color(0xFFFF2079),
          size: 100.0,
        )
      ],
    );
  }

  Widget _listOfRecipes() {
    return Column(
      children: [
        // const Text(
        //   'You have: ',
        //   style: TextStyle(
        //     fontSize: 43.0,
        //     fontFamily: 'WorkSans',
        //     color: Color(0xFF04005E),
        //   ),
        // ),
        const SizedBox(
          height: 40.0,
        ),
        Column(
          children: _recipeParser(output),
        ),
      ],
    );
  }

  List<Widget> _recipeParser(output) {
    List<Widget> listOfRandomRecipe = [];
    for (final item in output.keys) {
      listOfRandomRecipe.add(
        TextButton(
          onPressed: () async {
            setState(() {
              globals.itemId = item;
            });

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const CollaborativeRecipeSuggestion();
            }));
          },
          child: ListTile(
            leading: const Icon(
              Icons.emoji_food_beverage_sharp,
              color: Color(0xFF04005E),
            ),
            title: Text(
              output[item].toString(),
              style: const TextStyle(
                fontSize: 25.0,
                fontFamily: 'WorkSans',
                color: Color(0xFF04005E),
              ),
            ),
          ),
        ),
      );
    }
    return listOfRandomRecipe;
  }
}
