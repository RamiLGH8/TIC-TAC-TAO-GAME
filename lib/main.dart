import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 8, 83),
        appBar: AppBar(
          title: Center(
            child: Text('TIC-TAC-TOE'),
          ),
          backgroundColor: Color.fromARGB(255, 0, 43, 78),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
                child: Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 46, 2, 104),
                    padding: EdgeInsets.all(25))),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                'Quit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 46, 2, 104),
                padding: EdgeInsets.all(25),
              ),
            ),
          ]),
        ),
      )),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<List<int>> gameBoard = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];
  int currentPlayer = 1;
  bool isVisible = false;
  bool isVisible1 = false;
  void changeListState(int row, int column, int currentPlayer) {
    if (checkForWinner(gameBoard) == 0) {
      if (currentPlayer == 1 && gameBoard[row][column] == 0) {
        gameBoard[row][column] = 1;
      }
      if (currentPlayer == 2 && gameBoard[row][column] == 0) {
        gameBoard[row][column] = 2;
      }
    }
  }

/////////////////////////////////////////////////
  void resetGame() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        gameBoard[i][j] = 0;
      }
    }
    currentPlayer = 1;
  }

///////////////////////////////////////////////////
  int checkForWinner(List<List<int>> gameBoard) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (gameBoard[i][0] != 0 &&
          gameBoard[i][0] == gameBoard[i][1] &&
          gameBoard[i][1] == gameBoard[i][2]) {
        return gameBoard[i][0];
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (gameBoard[0][i] != 0 &&
          gameBoard[0][i] == gameBoard[1][i] &&
          gameBoard[1][i] == gameBoard[2][i]) {
        return gameBoard[0][i];
      }
    }

    // Check diagonals
    if (gameBoard[0][0] != 0 &&
        gameBoard[0][0] == gameBoard[1][1] &&
        gameBoard[1][1] == gameBoard[2][2]) {
      return gameBoard[0][0];
    }

    if (gameBoard[0][2] != 0 &&
        gameBoard[0][2] == gameBoard[1][1] &&
        gameBoard[1][1] == gameBoard[2][0]) {
      return gameBoard[0][2];
    }

    // If there is no winner, return 0
    return 0;
  }

  int winner = 0;
//////////////////////////////////
  String getMarkText(int mark) {
    if (mark == 1) {
      return 'X';
    } else if (mark == 2) {
      return 'O';
    } else {
      return '';
    }
  }

//////////////////////////////////
  void switchPlayer(int currentPlayer) {
    if (currentPlayer == 1) {
      currentPlayer = 2;
    } else {
      currentPlayer = 1;
    }
  }

  ////////
  bool checkIfFull(List<List<int>> gameBoard) {
    int num = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameBoard[i][j] != 0) {
          num++;
        }
      }
    }
    if (num == 9)
      return true;
    else
      return false;
  }

/////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 43, 78),
            title: Center(child: Text('Tic Tac Toe')),
          ),
          backgroundColor: Color.fromARGB(255, 19, 8, 83),
          body: Column(
            children: [
              Container(
                height: 360,
                color: Color.fromARGB(255, 64, 9, 73),
                margin: EdgeInsets.only(top: 150),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () {
                        // Handle player move
                        setState(() {
                          changeListState(row, col, currentPlayer);
                          if (checkForWinner(gameBoard) == 1 ||
                              checkForWinner(gameBoard) == 2) {
                            isVisible = true;
                            winner = checkForWinner(gameBoard);
                          } else {
                            if (currentPlayer == 1) {
                              currentPlayer = 2;
                            } else if (currentPlayer == 2) {
                              currentPlayer = 1;
                            }
                            if (gameBoard[row][col] == 0)
                              getMarkText(gameBoard[row][col]);
                          }
                          if ((checkIfFull(gameBoard) == true)) {
                            isVisible1 = true;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            getMarkText(gameBoard[row][col]),
                            style: TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 9,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: isVisible1,
                  child: Column(children: [
                    Center(
                        child: Text(
                      'There is no winner',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        resetGame();
                        setState(() {
                          getMarkText(0);
                        });
                        isVisible1 = false;
                      },
                    ),
                  ])),
              Visibility(
                  visible: isVisible,
                  child: Column(children: [
                    Center(
                        child: Text(
                      'The winner is player number $winner',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        resetGame();
                        setState(() {
                          getMarkText(0);
                        });
                        isVisible = false;
                      },
                    ),
                  ]))
            ],
          )),
    ));
  }
}
