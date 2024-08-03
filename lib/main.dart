import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicTacToe',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 26,
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              'TicTacToe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: const Center(child: Board()),
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
      ),
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<String> _symbols = ['X', 'O'];
  // ignore: prefer_final_fields
  List<List<String>> _mark =
      List.generate(3, (_) => List.generate(3, (_) => ''));
  // ignore: prefer_final_fields
  bool _ingame = false;
  String _playerSymbol = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _showSymbolSelectionDialog);
  }

  void _showSymbolSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Your Symbol"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(2, (int index) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _playerSymbol = _symbols[index];
                    _ingame = true;
                  });
                  _resetBoard;
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  _symbols[index],
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  void _resetBoard() {
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        setState(() => _mark[r][c] = '');
      }
    }
  }

  void _tap(int row, int col, String player) {
    if (_ingame) {
      setState(() {
        _mark[row][col] = player;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(75),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: 9,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, index) {
        final int row = index ~/ 3;
        final int col = index % 3;
        return ElevatedButton(
          onPressed: () => _tap(row, col, _playerSymbol),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 58, 58, 58),
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Text(
            _mark[row][col],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
