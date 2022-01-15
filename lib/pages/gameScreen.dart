import 'package:flutter/material.dart';
import 'package:flutter_game_michi/colors/color.dart';
import 'package:flutter_game_michi/pages/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; //numero de draw
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //el score de las diferentes combianaciones del juego [Row 1,2,3, Col 1,2,3, Diag 1,2];

  //declaramos un nuevo componente de juego
  Game game = Game();

  //iniciamos el Game Board
  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} turn".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 58,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: boardWidth,
            width: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/
                  3, // el operador ~/ siempre debes evidenciar a entero y devolver un Int como resultado
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          //nesecitamso agregar el nuevo valor del board y refrescar el screen
                          //también necesitamos alternar el jugador
                          //nosotros necesitamso aplicar el click only y el  campo es empty
                          //creamos un botond e repeticion de juego

                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scoreboard, 3);
                              if (gameOver) {
                                result = "$lastValue es el ganador";
                              } else if (!gameOver && turn == 9) {
                                result = "Emapate";
                                gameOver = true;
                              }
                              if (lastValue == "X")
                                lastValue = "0";
                              else
                                lastValue = "X";
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X"
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 64.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            result,
            style: TextStyle(
              color: Colors.white,
              fontSize: 54.0,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                //borrar la pizarra
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: const Icon(Icons.replay),
            label: Text("Repetir el juego"),
          ),
        ],
      ),
    );
  }
}
