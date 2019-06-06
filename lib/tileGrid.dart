import 'tile.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class TileGrid {
  List<int> cur = List(2);

  List<List<Tile>> tileGrid;

  int maxRows;
  int maxCols;

  TileGrid(int maxCols, int maxRows) {
    this.maxRows = maxRows;
    this.maxCols = maxCols;

    tileGrid = List(maxRows);
    for (int row = 0; row < maxRows; row++) {
      tileGrid[row] = List(maxCols);
      for (int column = 0; column < maxCols; column++) {
        tileGrid[row][column] = new Tile(column, row);
      }
    }
  }

  rowLength() {
    return tileGrid[0].length;
  }

  columnLength() {
    return tileGrid.length;
  }

  getRow(int index) {
    List<Tile> row = List(this.rowLength());

    this.generateMaze();

    String info = '';
    int i = 0;
    for (var tile in tileGrid[index]) {
      row[i] = tile;
      info = info + tile.visited.toString(); //tile.getLocation().toString();
      i++;
    }
    return row;
  }

  generateMaze() {
    cur[0] = 0;
    cur[1] = 0;
    tileGrid[cur[0]][cur[1]].setVisited(true);
    List<Tile> stack = List();
    List<List<int>> neighbours = List();
    bool unvisitedCells = true;

    while (unvisitedCells) {
      neighbours.clear();
      if (cur[0] + 1 < maxRows && !tileGrid[cur[0] + 1][cur[1]].visited) {
        neighbours.add([cur[0] + 1, cur[1]]);
      }
      if (cur[0] - 1 >= 0 && !tileGrid[cur[0] - 1][cur[1]].visited) {
        neighbours.add([cur[0] - 1, cur[1]]);
      }
      if (cur[1] + 1 < maxCols && !tileGrid[cur[0]][cur[1] + 1].visited) {
        neighbours.add([cur[0], cur[1] + 1]);
      }
      if (cur[1] - 1 >= 0 && !tileGrid[cur[0]][cur[1] - 1].visited) {
        neighbours.add([cur[0], cur[1] - 1]);
      }

      if (neighbours.length > 0) {
        //step 1
        Random rand = Random();
        int next = rand.nextInt(neighbours.length);

        //step 2
        stack.add(tileGrid[cur[0]][cur[1]]);

        //step 3
          if      (cur[0] - neighbours[next][0] == 1) {

          tileGrid[cur[0]][cur[1]].wWall = false;
          tileGrid[neighbours[next][0]][neighbours[next][1]].eWall = false;

        } else if (cur[0] - neighbours[next][0] == -1) {

          tileGrid[cur[0]][cur[1]].eWall = false;
          tileGrid[neighbours[next][0]][neighbours[next][1]].wWall = false;

        } else if (cur[1] - neighbours[next][1] == 1) {

          tileGrid[cur[0]][cur[1]].nWall = false;
          tileGrid[neighbours[next][0]][neighbours[next][1]].sWall = false;

        } else if (cur[1] - neighbours[next][1] == -1) {

          tileGrid[cur[0]][cur[1]].sWall = false;
          tileGrid[neighbours[next][0]][neighbours[next][1]].nWall = false;
        }

        //step 4
        cur = neighbours[next];
        tileGrid[cur[0]][cur[1]].setVisited(true);
        String neighbour = neighbours[next].toString();
        debugPrint('Neighbours available at: $neighbours, moving to $neighbour');

      } else if (stack.length > 0) {

        Tile previous = stack.removeLast();
        cur[0] = previous.row;
        cur[1] = previous.column;

        debugPrint('Backtracking to: $cur');

      } else {

        debugPrint('Stack empty.');
        printGrid(tileGrid);
        unvisitedCells = false;

      }
    }
  }

  printGrid(List<List<Tile>> grid) {
    for (int i = 0; i < grid.length; i++) {
      for(int j = 0; j < grid[i].length; j++){
        Tile cell = grid[i][j];
        bool n = cell.nWall;
        bool e = cell.eWall;
        bool s = cell.sWall;
        bool w = cell.wWall;
        debugPrint('Cell $i, $j - N:$n E:$e S:$s W:$w');
      }
    }
  }
}
