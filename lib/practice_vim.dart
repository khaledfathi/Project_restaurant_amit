import 'package:flutter/material.dart';

main (){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SingleChildScrollView(
        child: Column(
          children: [
            Text('Date = 10/10/2022'),
            Text('data'),
            Text('I\'m practicing VIM keys'),
            Text('Date = 10/10/2022'),
            Text(''),
          ],
        ),
      ),
    );
  }
}

