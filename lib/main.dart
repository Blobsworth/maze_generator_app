import 'package:flutter/material.dart';
import 'tile.dart';
import 'tileGrid.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(BaseContainer());

class BaseContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.black,
        brightness: Brightness.dark,
      ),
      home: ContentContainer(),
    );
  }
}

class ContentContainer extends StatefulWidget {
  @override
  _Content createState() => _Content();
}

class _Content extends State<ContentContainer> {
  var responses = [];
  List currentLocation = [0, 0];

  static TileGrid testGrid = TileGrid(50, 50);

  //
  //GUI WIDGETS
  //
  @override
  Widget build(BuildContext context) {
    testGrid.generateMaze();
    return Scaffold(
      body: SafeArea(
        child: Stack(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: responses.length + 1,
                itemBuilder: (context, index) {
                  if (index < responses.length) {
                    return ListTile(
                      title: Text(
                        responses[index],
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontFamily: 'Courier'),
                      ),
                    );
                  } else {
                    return TextField(
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontFamily: 'Courier'),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.green[900],
                              fontFamily: 'Courier'),
                          border: InputBorder.none,
                          hintText:
                              'Where would you like to go next? (n,s,e,w)'),
                      autofocus: true,
                      onSubmitted: (value) {
                        //parse input
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
  //GUI WIDGETS
  //
}
