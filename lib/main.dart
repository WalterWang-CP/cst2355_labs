import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0.0; // Changed from int to var (double)
  double myFontSize = 30.0; // New font size variable

  void setNewValue(double value) {
    setState(() {
      _counter = value; // Update counter
      myFontSize = value; // Update font size
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: myFontSize), // Apply font size
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: myFontSize), // Apply font size
            ),
            Slider(
              value: _counter,
              min: 10.0,
              max: 100.0,
              divisions: 10,
              label: _counter.toStringAsFixed(1),
              onChanged: setNewValue,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setNewValue(_counter + 1.0),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
