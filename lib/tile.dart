class Tile {
  int column;
  int row;

  bool nWall = true;
  bool eWall = true;
  bool sWall = true;
  bool wWall = true;

  bool visited = false;

  List<int> location;

  Tile(this.column, this.row) {
    location = new List<int>(2);
    location[0] = column;
    location[1] = row;
  }

  getLocation() {
    return location;
  }

  setVisited(bool visited){
    this.visited = visited;
  }
}
