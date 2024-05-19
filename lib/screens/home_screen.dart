import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;

  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];

  int filledBoxes = 0;

  bool gameHasResult = false;

  int scoreX = 0;
  int scoreO = 0;

  String winnerTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "TicTacToe",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              clearGame();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            getScoreBoard(),
            SizedBox(height: 20),
            getResultButton(),
            SizedBox(height: 20),
            getGridView(),
            SizedBox(height: 5),
            getTurn(),
          ],
        ),
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white, width: 2.0),
          ),
          onPressed: () {
            setState(() {
              gameHasResult = false;
              clearGame();
            });
          },
          child: Text("$winnerTitle, play again!")),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? "O" : "X",
      style: TextStyle(
          color: isTurnO ? Colors.white : Colors.red,
          fontSize: 70.0,
          fontWeight: FontWeight.bold),
    );
  }

  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 160,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Player O",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$scoreO",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              )
            ],
          ),
        ),
        Container(
          width: 160,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Player X",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$scoreX",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: Center(
                child: Text(
                  xOrOList[index],
                  style: TextStyle(
                      color: xOrOList[index] == "O" ? Colors.white : Colors.red,
                      fontSize: 100.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResult) {
      // return; doesn't run other code in tapped method...
      return;
    }
    setState(() {
      if (xOrOList[index] == "") {
        xOrOList[index] = isTurnO ? "O" : "X";
        filledBoxes += 1;
        isTurnO = !isTurnO;
      } else {
        return;
      }
      checkWinner();
    });
  }

  void checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != "") {
      setResult(xOrOList[0], "Winner is " + xOrOList[0]);
      return;
    } else if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != "") {
      setResult(xOrOList[3], "Winner is " + xOrOList[3]);
      return;
    } else if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != "") {
      setResult(xOrOList[6], "Winner is " + xOrOList[6]);
      return;
    } else if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[3] != "") {
      setResult(xOrOList[0], "Winner is " + xOrOList[0]);
      return;
    } else if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != "") {
      setResult(xOrOList[2], "Winner is " + xOrOList[2]);
      return;
    } else if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != "") {
      setResult(xOrOList[0], "Winner is " + xOrOList[0]);
      return;
    } else if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != "") {
      setResult(xOrOList[1], "Winner is " + xOrOList[1]);
      return;
    } else if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != "") {
      setResult(xOrOList[2], "Winner is " + xOrOList[2]);
      return;
    } else if (filledBoxes == 9) {
      setResult("", "Draw");
      return;
    } else {
      return;
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == "X") {
        scoreX += 1;
      } else if (winner == "O") {
        scoreO += 1;
      } else {
        scoreX += 1;
        scoreO += 1;
      }
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = "";
      }
      filledBoxes = 0;
      scoreX = 0;
      scoreO = 0;
    });
  }
}
