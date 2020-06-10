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
  int round = 0;
  List<String> gameState = [
    "empty",
    "empty",
    "empty",
    "empty",
    "empty",
    "empty",
    "empty",
    "empty",
    "empty",
  ];
  void doTurn(int index) {
    setState(() {
      round += 1;
    });
  }

  Expanded createBox(int index) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          setState(() {
            doTurn(index);
          });
        },
        child: Icon(Icons.bubble_chart, color: Colors.blue),
      ),
    );
  }

  Divider insertLine() {
    // if (horizontal) {
      return const Divider(
        height: 20,
        thickness: 5,
        color: Colors.black,
        indent: 20,
      );
    // }
    // else {
    //   return VerticalDivider(
    //     height: 20,
    //     thickness: 5,
    //     color: Colors.black,
    //   );
    // }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: <Widget>[
          Row(children: [Text('Player 1\'s turn')],),
          Expanded(
            child: Row(
              children: <Widget>[
                createBox(0),
                insertLine(),
                createBox(1),
                insertLine(),
                createBox(2),
              ],
            ),
          ),
          insertLine(),
          Expanded(
            child: Row(
              children: <Widget>[
                createBox(3),
                createBox(4),
                createBox(5),
              ],
            ),
          ),
          insertLine(),
          Expanded(
            child: Row(
              children: <Widget>[
                createBox(6),
                createBox(7),
                createBox(8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
