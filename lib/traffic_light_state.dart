enum Player {
  none('-'),
  player1('Player 1'),
  player2('Player 2');

  final String str;

  const Player(this.str);

  @override
  String toString() => str;
}

enum Color { green, red, yellow, none }

class TrafficLightsState {
  static const colSize = 3;
  static const rowSize = 4;
  static const numCells = rowSize * colSize;
  static const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [9, 10, 11],
    [0, 3, 6],
    [3, 6, 9],
    [1, 4, 7],
    [4, 7, 10],
    [2, 5, 8],
    [5, 8, 11],
    [0, 4, 8],
    [2, 4, 6],
    [3, 7, 11],
    [5, 7, 9]
  ];
  late List<Color> board;
  late Player currentPlayer, winner;
  late int turn;

  TrafficLightsState() {
    reset();
  }

  void reset() {
    board = List.filled(numCells, Color.none);
    currentPlayer = Player.player1;
    winner = Player.none;
    turn = 0;
  }

  @override
  String toString() {
    var sb = StringBuffer();
    for (int i = 0; i < board.length; i++) {
      sb.write(board[i].toString());
      if (i % colSize == rowSize - 1) sb.writeln();
    }
    sb.writeln(getStatus());
    return sb.toString();
  }

  bool playAt(int i) {
    if (winner == Player.none && board[i] != Color.red) {
      if (board[i] == Color.none) {
        board[i] = Color.green;
      } else if (board[i] == Color.green) {
        board[i] = Color.yellow;
      } else if (board[i] == Color.yellow) {
        board[i] = Color.red;
      }
      // board[i] = Color.green;
      _checkWinner();
      currentPlayer =
          (currentPlayer == Player.player1) ? Player.player2 : Player.player1;
      turn++;

      return true;
    }
    return false;
  }

  void _checkWinner() {
    for (List<int> line in lines) {
      if (board[line[0]] != Color.none &&
          board[line[0]] == board[line[1]] &&
          board[line[0]] == board[line[2]]) {
        winner = currentPlayer;
      }
    }
  }

  Player getWinner() => winner;
  bool isGameOver() {
    if (winner == Player.player1 || winner == Player.player2) {
      return true;
    }
    return false;
  }

  String getStatus() {
    if (isGameOver()) {
      if (winner == Player.none) {
        return 'Draw.';
      } else {
        return '$winner wins!';
      }
    } else {
      return '$currentPlayer to play.';
    }
  }
}

// Test code
// void main() {
//   var s = TrafficLightsState();
//   print(s);
//   var plays = [4, 0, 2, 6, 5, 7, 1, 8];
//   for (var i in plays) {
//     print('playing at $i.\n');
//     s.playAt(i);
//     print(s);
//   }
// }
