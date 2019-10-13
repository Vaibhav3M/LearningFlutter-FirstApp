import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Center(
          //child: const Text('Hello World'),
          child: RandomWords(),
        ),
      ),
    );
  }
}

// New StateFull widget class

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

//State class

class RandomWordsState extends State<RandomWords> {


  // List of word pairs
  final List<WordPair> _list = <WordPair>[];
  // Selected word pairs
  final List<WordPair> _saved = <WordPair>[];
  //Text Style
  final TextStyle _textStyle = const TextStyle(fontSize: 18);


//Main builder method
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startip Name Generator"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildList(),
    );
  }

  // widget building list
  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;

          if (index >= _list.length) {
            _list.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_list[index]);
        });
  }

  // widget builder for generating list rows
  Widget _buildRow(WordPair pair) {

    // bool to check if pair saved
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _textStyle,
      ),
      trailing: Icon(
        alreadySaved ? Icons.check : Icons.add,
        color: alreadySaved ? Colors.red : null,
      ),
      // Method action on tap of the row item
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }
          else{
            _saved.add(pair);
          }
        });
      },
    );
  }

  // Method to open new controller with saved data
  void _pushSaved(){
    
    Navigator.of(context).push(

      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _textStyle,
                ),
              );
            },
          );
          // add list widget
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Suggestions"),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
