class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardlenth = 9; // board de 3*3 bloques
  static final blocSize = 100.0;

  //creamso la empty board
  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardlenth, (index) => Player.empty);

  //necesitamos el build de check ganador del algoritmo
  //nosostros necesitamso primero la declaracion de scaoreboard in our main file

  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;

    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    //checking si nosotros tenemso 3 o -3 en el score board
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }

    //por defecto devolverá falso
    return false;
  }
}
