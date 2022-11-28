import 'package:flutter/material.dart';
import 'package:traffic_lights/traffic_light_state.dart';
import 'package:flutter/services.dart';

final imageMap = {
  Color.green: Image.asset('assets/images/green.png'),
  Color.red: Image.asset('assets/images/red.png'),
  Color.yellow: Image.asset('assets/images/yellow.jpg')
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Lights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Traffic Lights'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _gameState = TrafficLightsState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100.0, minHeight: 120.0),
          child: AspectRatio(
            aspectRatio: 5 / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Stack(
                      children: [
                        Image.asset('assets/images/4x3.jpg'),
                        GridView.builder(
                          itemCount: TrafficLightsState.numCells,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: TrafficLightsState.colSize),
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () => _processPress(index),
                              child: imageMap[_gameState.board[index]] ??
                                  Container(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(_gameState.getStatus(),
                              style: const TextStyle(fontSize: 36)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _resetGame,
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 36),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processPress(int index) {
    setState(() {
      _gameState.playAt(index);
    });
  }

  void _resetGame() {
    setState(() {
      _gameState.reset();
    });
  }
}
