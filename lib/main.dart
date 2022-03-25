import 'package:flutter/material.dart';
import 'package:flutter_train/screens/posts.dart';
import 'package:flutter_train/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_train/screens/testpost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //  primarySwatch: Colors.red,
          ),
      home: Posts(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool x = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 6,
        title: Text("Test"),
        centerTitle: true,
        actions: [Text("Test1"), Text("Test")],
        leading: Center(
          child: Text(
            "Test3",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                    width: 300,
                    height: 200,
                    child: Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                    width: 300,
                    height: 200,
                    child: Image.asset('assets/images/download.jpg')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Image.asset('assets/images/owl-2.jpg')),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Salary Cap'),
                    // Stack( // Will cause error
                    //   fit: StackFit.expand,
                    //   children: <Widget>[
                    //     Positioned(
                    //       top: 0,
                    //       left: 0,
                    //       width: 200,
                    //       child: Text('Salary Cap'),
                    //     ),
                    //   ],
                    // ),
                    // Expanded(
                    //   child: Container(
                    //     width: double.infinity,
                    //     child: CustomPaint(painter: LineDashedPainter()),
                    //   ),
                    // ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: '\$'),
                          TextSpan(
                            text: '2000',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('Row 1', style: TextStyle(fontSize: 18)),
                    Text(
                      'Row  2',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Row 1', style: TextStyle(fontSize: 32)),
                    Baseline(
                        baseline: 25.0,
                        baselineType: TextBaseline.alphabetic,
                        child: Text('Row  2')),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      x = !x;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.menu,
                      color: x ? Colors.green : Colors.red,
                      size: 40,
                    )),
                Container(
                  height: 70,
                  width: 50,
                  child: Center(child: Text("Test")),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red.shade500,
                      ),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20)),
                      color: Colors.amber),
                )
                // Icon(
                //   Icons.favorite,
                //   color: Colors.pink,
                //   size: 24.0,
                //   semanticLabel: 'Text to announce in accessibility modes',
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Text("Test"),
      ),
    );
  }
}
