import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SomeWords extends StatefulWidget {
  const SomeWords({super.key});
  @override
  State<SomeWords> createState() => _SomeWordsState();
}

class _SomeWordsState extends State<SomeWords> {
  final _suggestions = <WordPair>[];
  final _savedWords = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name Generator"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: "Saved Startup Names",
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        if (index.isOdd) return const Divider();
        final newIndex = index ~/ 2;
        if (newIndex >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        final _alreadySaved = _savedWords.contains(_suggestions[newIndex]);
        return ListTile(
          title: Text(_suggestions[newIndex].asPascalCase, style: _biggerFont),
          trailing: Icon(
            _alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: _alreadySaved ? Colors.red : null,
            semanticLabel: _alreadySaved ? "Unsave Name" : "Save Name",
          ),
          onTap: () {
            setState(() {
              if (_alreadySaved) {
                _savedWords.remove(_suggestions[newIndex]);
              } else {
                _savedWords.add(_suggestions[newIndex]);
              }
            });
          },
        );
      }),
    );
  }

//--------------------------------------------------
  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        final tiles = _savedWords.map(
          (pair) {
            //every iteration, the pair is named pair
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final divided = tiles.isNotEmpty
            ? ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList()
            : <Widget>[];
        return Scaffold(
            appBar: AppBar(title: const Text("Saved Suggestions")),
            body: ListView(children: divided));
      },
    ));
  }
}
