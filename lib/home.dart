import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:x_o_game/logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  ...switchWithStart(context),
                  expandedGrid(context),
                  resultWithRepeat(context),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ...switchWithStart(context),
                        resultWithRepeat(context),
                      ],
                    ),
                  ),
                  expandedGrid(context),
                ],
              ),
      ),
    );
  }

  List<Widget> switchWithStart(BuildContext context) {
    return [
      SwitchListTile.adaptive(
        activeColor: Theme.of(context).splashColor,
        title: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
          opacity: 0.9,
          alwaysIncludeSemantics: true,
          child: SizedBox(
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Turn on/off two players',
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        blurRadius: 1.0,
                        offset: Offset(1.0, 1.0),
                      ),
                      Shadow(
                        color: Colors.blue,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        "It's $activePlayer turn".toUpperCase(),
        style: const TextStyle(
          fontSize: 30.0,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 70.0,
      ),
    ];
  }

  Padding resultWithRepeat(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).orientation == Orientation.portrait
          ? const EdgeInsets.all(105.0)
          : const EdgeInsets.all(81),
      child: Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            curve: Curves.linear,
            opacity: 0.9,
            alwaysIncludeSemantics: true,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 7.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText(result),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          ElevatedButton.icon(
            autofocus: true,
            onPressed: () {
              setState(() {
                Player.playerx = [];
                Player.playero = [];
                activePlayer = 'X';
                gameOver = false;
                turn = 0;
                result = '';
              });
            },
            icon: const Icon(
              Icons.replay,
            ),
            label: const Padding(
              padding: EdgeInsets.all(20.0),
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                curve: Curves.linear,
                opacity: 0.9,
                alwaysIncludeSemantics: true,
                child: Text(
                  "Repeat the game",
                  style: TextStyle(
                    fontSize: 25.0,
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        blurRadius: 1.0,
                        offset: Offset(1.0, 1.0),
                      ),
                      Shadow(
                        color: Colors.blue,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).splashColor,
                ),
                shadowColor: MaterialStateProperty.all(
                  Colors.white,
                ),
                animationDuration: const Duration(
                  milliseconds: 2000,
                )),
          ),
        ],
      ),
    );
  }

  Expanded expandedGrid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        crossAxisCount: 3,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            onTap: gameOver ? null : () => play(index),
            splashColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                color: Theme.of(context).shadowColor,
              ),
              child: Center(
                child: Text(
                  Player.playerx.contains(index)
                      ? "X"
                      : Player.playero.contains(index)
                          ? "O"
                          : "",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Player.playerx.contains(index)
                        ? Colors.blue
                        : Colors.yellow[100],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // start the game .
  play(int index) async {
    if ((Player.playerx.isEmpty || !Player.playerx.contains(index)) &&
        (Player.playero.isEmpty || !Player.playero.contains(index))) {
      game.playGame(activePlayer, index);
      updateActivePlayer();
    }
    if (!isSwitched && !gameOver && turn != 9) {
      await game.autoPlay(activePlayer);
      updateActivePlayer();
    }
  }

  // update the player with the result .
  void updateActivePlayer() {
    setState(() {
      activePlayer = (activePlayer == "X") ? "O" : "X";
      turn++;

      String win = game.checkWinner();
      if (win != "") {
        gameOver = true;
        if (win == "X") {
          result = "X is a winner";
          showToast(
            "O: Good luck, try again",
          );
        } else {
          result = "O is a winner";
          showToast(
            "X: Good luck, try again",
          );
        }
      } else if (!gameOver && turn == 9) {
        result = "There no any a winner";
        showToast(
          "Repeat the game",
        );
      }
    });
  }

  // show message to show result .
  void showToast(String message) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO_REVERSED,
      body: Center(
        heightFactor: 11,
        child: Text(
          message,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ).show();
  }
}
