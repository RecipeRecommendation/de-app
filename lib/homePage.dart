import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'ingredientsPage.dart';
import 'package:de_app/RandomRecipeSuggestionPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final animationWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: animationWidth,
                height: 200.0,
                child: Container(
                  // alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 100.0, left: 30.0, right: 30.0),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 43.0,
                      fontFamily: 'WorkSans',
                      color: Colors.blue.shade800,
                    ),
                    child: AnimatedTextKit(
                      pause: const Duration(milliseconds: 500),
                      animatedTexts: [
                        FadeAnimatedText(
                          'Hello Foodies!',
                          textStyle: const TextStyle(
                            fontSize: 45.0,
                          ),
                          duration: const Duration(milliseconds: 3000),
                        ),
                        FadeAnimatedText(
                          'Welcome To..',
                          textStyle: const TextStyle(fontSize: 37.0),
                          duration: const Duration(milliseconds: 2000),
                        ),
                        TypewriterAnimatedText(
                          'Recipe Recommender ',
                          speed: const Duration(milliseconds: 100),
                          textStyle: const TextStyle(fontSize: 42.0),
                        ),
                      ],
                      repeatForever: true,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 300.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: const Text('Log Out!'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 55.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: SizedBox(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  child: getRecipeCard(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: SizedBox(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  child: getIngredientsCard(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: SizedBox(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  child: getSelfOrderCard(),
                ),
              ),
            ],
          ),
        ));
  }

  Widget getRecipeCard() {
    return TextButton(
      onPressed: () {
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const RandomRecipeSuggestionPage();
              },
            ),
          );
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(35.0),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/recipe_card.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.shade100,
                    blurRadius: 4,
                    offset: const Offset(4, 8),
                  )
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: const Text(
              "Cooking, ",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 20.0),
            child: const Text(
              "    made easy!",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 97.0, left: 20.0),
            child: const Text(
              "Get Awesome Recipes!",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 133.0, left: 20.0),
            child: Row(
              children: const [
                Icon(
                  Icons.emoji_food_beverage,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '500+ recipes!',
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getIngredientsCard() {
    return TextButton(
      onPressed: () {
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const IngredientsPage();
              },
            ),
          );
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(35.0),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/ingredients_card.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.shade100,
                    blurRadius: 4,
                    offset: const Offset(4, 8),
                  )
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: const Text(
              "Get list of ",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 20.0),
            child: const Text(
              "    Ingredients!",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 97.0, left: 20.0),
            child: const Text(
              "Know your Ingredients!",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 133.0, left: 20.0),
            child: Row(
              children: const [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Let's find out!",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelfOrderCard() {
    return TextButton(
      onPressed: () {},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(35.0),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/home_delivery.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.shade100,
                    blurRadius: 4,
                    offset: const Offset(4, 8),
                  )
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: const Text(
              "Get Groceries, ",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blueGrey,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 20.0),
            child: const Text(
              "    at your doorstep!",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blueGrey,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 97.0, left: 20.0),
            child: const Text(
              "Hassle Free!",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueGrey,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 133.0, left: 20.0),
            child: Row(
              children: const [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '500+ orders!',
                  style: TextStyle(fontSize: 22.0, color: Colors.blueGrey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
