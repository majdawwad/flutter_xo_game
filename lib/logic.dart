import 'dart:math';

class Player {
  static const x = "x";
  static const y = "y";
  static const empty = "";

  static List<int> playerx = [];
  static List<int> playero = [];
}

// add method on class list
extension ContainAll on List {
  bool containAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  // start playing
  void playGame(String activePlayer, int index) {
    if (activePlayer == "X") {
      Player.playerx.add(index);
    } else {
      Player.playero.add(index);
    }
  }

  // who is the winner
  String checkWinner() {
    String winner = "";

    if (Player.playerx.containAll(0, 1, 2) ||
        Player.playerx.containAll(3, 4, 5) ||
        Player.playerx.containAll(6, 7, 8) ||
        Player.playerx.containAll(0, 3, 6) ||
        Player.playerx.containAll(1, 4, 7) ||
        Player.playerx.containAll(2, 5, 8) ||
        Player.playerx.containAll(0, 4, 8) ||
        Player.playerx.containAll(2, 4, 6)) {
      winner = "X";
    } else if (Player.playero.containAll(0, 1, 2) ||
        Player.playero.containAll(3, 4, 5) ||
        Player.playero.containAll(6, 7, 8) ||
        Player.playero.containAll(0, 3, 6) ||
        Player.playero.containAll(1, 4, 7) ||
        Player.playero.containAll(2, 5, 8) ||
        Player.playero.containAll(0, 4, 8) ||
        Player.playero.containAll(2, 4, 6)) {
      winner = "O";
    } else {
      winner = "";
    }

    return winner;
  }

  // auto pc or device play
  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyAutoPlayer = [];

    for (var i = 0; i < 9; i++) {
      if (!(Player.playerx.contains(i) || Player.playero.contains(i))) {
        emptyAutoPlayer.add(i);
      }
    }
    // start - center
    if (Player.playero.containAll(0, 1) && emptyAutoPlayer.contains(2)) {
      index = 2;
    } else if (Player.playero.containAll(3, 4) && emptyAutoPlayer.contains(5)) {
      index = 5;
    } else if (Player.playero.containAll(6, 7) && emptyAutoPlayer.contains(8)) {
      index = 8;
    } else if (Player.playero.containAll(0, 3) && emptyAutoPlayer.contains(6)) {
      index = 6;
    } else if (Player.playero.containAll(1, 4) && emptyAutoPlayer.contains(7)) {
      index = 7;
    } else if (Player.playero.containAll(2, 5) && emptyAutoPlayer.contains(8)) {
      index = 8;
    } else if (Player.playero.containAll(0, 4) && emptyAutoPlayer.contains(8)) {
      index = 8;
    } else if (Player.playero.containAll(2, 4) && emptyAutoPlayer.contains(6)) {
      index = 5;
    } else if (Player.playero.containAll(0, 2) && emptyAutoPlayer.contains(1)) {
      index = 1;
    } else if (Player.playero.containAll(3, 5) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playero.containAll(6, 8) && emptyAutoPlayer.contains(7)) {
      index = 7;
    } else if (Player.playero.containAll(0, 6) && emptyAutoPlayer.contains(3)) {
      index = 3;
    } else if (Player.playero.containAll(1, 7) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playero.containAll(2, 8) && emptyAutoPlayer.contains(5)) {
      index = 5;
    } else if (Player.playero.containAll(0, 8) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playero.containAll(2, 6) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playero.containAll(1, 2) && emptyAutoPlayer.contains(0)) {
      index = 0;
    } else if (Player.playero.containAll(4, 5) && emptyAutoPlayer.contains(3)) {
      index = 3;
    } else if (Player.playero.containAll(7, 8) && emptyAutoPlayer.contains(6)) {
      index = 6;
    } else if (Player.playero.containAll(3, 6) && emptyAutoPlayer.contains(0)) {
      index = 0;
    } else if (Player.playero.containAll(4, 7) && emptyAutoPlayer.contains(1)) {
      index = 1;
    } else if (Player.playero.containAll(5, 8) && emptyAutoPlayer.contains(2)) {
      index = 2;
    } else if (Player.playero.containAll(4, 8) && emptyAutoPlayer.contains(0)) {
      index = 0;
    } else if (Player.playero.containAll(4, 6) && emptyAutoPlayer.contains(2)) {
      index = 2;
    } else if (Player.playerx.containAll(0, 1) && emptyAutoPlayer.contains(2)) {
      index = 2;
    } else if (Player.playerx.containAll(3, 4) && emptyAutoPlayer.contains(5)) {
      index = 5;
    } else if (Player.playerx.containAll(6, 7) && emptyAutoPlayer.contains(8)) {
      index = 8;
    } else if (Player.playerx.containAll(0, 3) && emptyAutoPlayer.contains(6)) {
      index = 6;
    } else if (Player.playerx.containAll(1, 4) && emptyAutoPlayer.contains(7)) {
      index = 7;
    } else if (Player.playerx.containAll(2, 5) && emptyAutoPlayer.contains(8)) {
      index = 8;
    } else if (Player.playerx.containAll(0, 4) && emptyAutoPlayer.contains(8)) {
      index = 8;
    } else if (Player.playerx.containAll(2, 4) && emptyAutoPlayer.contains(6)) {
      index = 6;
    } else if (Player.playerx.containAll(0, 2) && emptyAutoPlayer.contains(1)) {
      index = 1;
    } else if (Player.playerx.containAll(3, 5) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playerx.containAll(6, 8) && emptyAutoPlayer.contains(7)) {
      index = 7;
    } else if (Player.playerx.containAll(0, 6) && emptyAutoPlayer.contains(3)) {
      index = 3;
    } else if (Player.playerx.containAll(1, 7) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playerx.containAll(2, 8) && emptyAutoPlayer.contains(5)) {
      index = 5;
    } else if (Player.playerx.containAll(0, 8) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playerx.containAll(2, 6) && emptyAutoPlayer.contains(4)) {
      index = 4;
    } else if (Player.playerx.containAll(1, 2) && emptyAutoPlayer.contains(0)) {
      index = 0;
    } else if (Player.playerx.containAll(4, 5) && emptyAutoPlayer.contains(3)) {
      index = 3;
    } else if (Player.playerx.containAll(7, 8) && emptyAutoPlayer.contains(6)) {
      index = 6;
    } else if (Player.playerx.containAll(3, 6) && emptyAutoPlayer.contains(0)) {
      index = 0;
    } else if (Player.playerx.containAll(4, 7) && emptyAutoPlayer.contains(1)) {
      index = 1;
    } else if (Player.playerx.containAll(5, 8) && emptyAutoPlayer.contains(2)) {
      index = 2;
    } else if (Player.playerx.containAll(4, 8) && emptyAutoPlayer.contains(0)) {
      index = 0;
    } else if (Player.playerx.containAll(4, 6) && emptyAutoPlayer.contains(2)) {
      index = 2;
    } else {
      Random r = Random();
      int randomIndex = r.nextInt(emptyAutoPlayer.length);

      index = emptyAutoPlayer[randomIndex];
    }
    playGame(activePlayer, index);
  }
}
