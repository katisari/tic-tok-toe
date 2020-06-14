import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TacToe(),
    );
  }
}

class TacToe extends StatefulWidget {
  @override
  _TacToeState createState() => _TacToeState();
}

class _TacToeState extends State<TacToe> {
  int currPlayer = 1;
  int gridSize = 3;
  String mainText = 'Player 1\'s turn to go';
  String whoWonText = '';
  bool gameEnded = false;
  List<String> gameState = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  List<int> row = [0,0,0];
  List<int> col = [0,0,0];
  int diag = 0;
  int antidiag = 0;

  int doTurn(int index) {
    List<int> coordinates =  calculateRowColumn(index);
    int rowIdx = coordinates[0];
    int colIdx = coordinates[1];
    setState(() {
      // currPlayer is opposite. if currplayer == 1, the player that did this turn is Player 2.
      int offset = currPlayer * 2 - gridSize;
      row[rowIdx] += offset;
      col[colIdx] += offset;
    
      if (rowIdx == colIdx) {
        diag += offset;
      }
      if (rowIdx + colIdx == gridSize-1) {
        antidiag += offset;
      }
      // nobody wins
    });
    // Player 1 wins
    if (row[rowIdx] == gridSize || col[colIdx] == gridSize || diag == gridSize || antidiag == gridSize) {
      return 1;
    }
    // Player 2 wins
    if (row[rowIdx] ==  -gridSize || col[colIdx] == -gridSize || diag == -gridSize || antidiag == -gridSize) {
      return 2;
    }
    return 0;
  }
  List<int> calculateRowColumn(int index) {
    int row = index ~/ 3;
    int col = index % 3;
    return [row, col];
  }

  // void create

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tok Toe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
              child: Column(children: [
          Text(mainText),
          Expanded(
              // use grid tile
              child: GridView.count(
            crossAxisCount: gridSize,
            children: List.generate(
              (gridSize * gridSize),
              (index) {
                return Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: FlatButton(
                    onPressed: (gameState[index] == "" && !gameEnded) ? () {
                      setState(() {
                        if (currPlayer == 1) {
                          mainText = 'Player 2\'s turn to go';
                          gameState[index] = "1";
                          currPlayer = 2;
                        } else {
                          mainText = 'Player 1\'s turn to go';
                          gameState[index] = "2";
                          currPlayer = 1;
                        }
                        int winner = doTurn(index);
                        if (winner != 0) {
                          whoWonText = "Player $winner won!";
                          gameEnded = true;
                        }

                      }) ;
                    }: null,
                    child: Text(gameState[index]),
                  ),
                );
              },
            ),
          ),),
          Text(whoWonText),
        ]),
      ),
    );
  }
}
