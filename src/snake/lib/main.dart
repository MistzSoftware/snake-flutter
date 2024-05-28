import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'snake.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int fruitPos;
  late var snake;

  int snakePos = 44;

  Widget gameGrid(Snake snake) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
      ), 
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(0.5),
          child: Container(
            color: getTileColor(index, snake)
          )
        );
      },
    );
  }

  MaterialColor getTileColor(int tilePos, Snake snake) {
    if (snake.getpos() == fruitPos && snake.getpos() == tilePos) {
        fruitPos = Random().nextInt(100);
      return Colors.green;
    }
    else if (fruitPos == tilePos) {
      return Colors.red;
    } else if (snake.getpos() == tilePos) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  Widget gameControls(Snake snake) {
    return Container(
      child: Expanded( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      snake.updateY(-1);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.black
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      snake.updateX(-1);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      snake.updateX(1);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      snake.updateY(1);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_downward,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ]
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();

    snake = Snake();
    fruitPos = Random().nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue[300],
          appBar: AppBar(
            backgroundColor: Colors.blue[300],
            leading: const Center(
                child: Text(
                  'Score: 0',
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ) 
                ),
            ),
            title: const Text(
              'Algo Snake',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            actions: const [
                Text(
                  'Time: 0',
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  )
                ),
            ],
          ),
          body: Column(
            children: [
              gameGrid(snake),
              Container(
                child: Expanded( 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gameControls(snake),
                    ]
                  )
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
