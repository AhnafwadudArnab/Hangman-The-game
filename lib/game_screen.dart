import 'package:flutter/material.dart';
import 'package:hangman/const/consts.dart';
import 'package:hangman/game/hidden_letters.dart';
import 'package:hangman/game/figure_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final alphabets = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  final word = "Peter".toUpperCase();
  var selectedChar = <String>[];
  var tries = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x657383),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Hangman : The Game"),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        figure(GameUI.hang, tries >= 0),
                        figure(GameUI.head, tries >= 1),
                        figure(GameUI.body, tries >= 2),
                        figure(GameUI.L_hand, tries >= 3),
                        figure(GameUI.r_hand, tries >= 4),
                        figure(GameUI.l_leg, tries >= 5),
                        figure(GameUI.r_leg, tries >= 6),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: word
                            .split("")
                            .map((e) => hiddenLetters(
                            e, !selectedChar.contains(e.toUpperCase())))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  crossAxisCount: 7,
                  children: alphabets.split("").map((e) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedChar.contains(e.toUpperCase())
                            ? (word.contains(e.toUpperCase())
                            ? Colors.green
                            : Colors.red)
                            : Colors.white10,
                      ),
                      onPressed: selectedChar.contains(e.toUpperCase())
                          ? null
                          : () {
                        setState(() {
                          selectedChar.add(e.toUpperCase());
                          if (!word.split("").contains(e.toUpperCase())) {
                            tries++;
                          }
                          checkGameOver();
                        });
                      },
                      child: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkGameOver() {
    if (tries >= 6) {
      showEndDialog("You Lost! The word was $word");
    } else if (word.split("").every((letter) => selectedChar.contains(letter))) {
      showEndDialog("You Won!");
    }
  }

  void showEndDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      selectedChar.clear();
      tries = 0;
    });
  }
}
