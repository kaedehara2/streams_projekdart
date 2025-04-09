import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream #PutraDamaskus',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.cyan;
  late ColorStream colorStream;

  int lastNumber = 0;
  late StreamController<int> numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer<int, int> transformer;
  late StreamSubscription subscription;
  late StreamSubscription subscription2; // ✅ listener kedua
  String values = ''; // ✅ untuk menyimpan angka-angka

  void stopStream() {
    numberStreamController.close();
  }

  @override
  void initState() {
    super.initState();

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;

    // ✅ Ubah menjadi broadcast stream
    Stream<int> stream = numberStreamController.stream.asBroadcastStream();

    // ✅ Listener pertama
    subscription = stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });

    // ✅ Listener kedua: Menyimpan angka ke variabel values
    subscription2 = stream.listen((event) {
      setState(() {
        values += '$event-';
      });
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone(() {
      print('OnDone was called');
    });

    // transformer = StreamTransformer<int, int>.fromHandlers(
    //   handleData: (value, sink) {
    //     sink.add(value * 10);
    //   },
    //   handleError: (error, trace, sink) {
    //     sink.add(-1);
    //   },
    //   handleDone: (sink) => sink.close(),
    // );

    // Stream transformedStream =
    //     numberStreamController.stream.transform(transformer);

    // transformedStream.listen((event) {
    //   setState(() {
    //     lastNumber = event;
    //   });
    // }).onError((error) {
    //   setState(() {
    //     lastNumber = -1;
    //   });
    // });

    // numberStream = NumberStream();
    // numberStreamController = numberStream.controller;
    // Stream stream = numberStreamController.stream;
    // stream.listen((event) {
    //   setState(() {
    //     lastNumber = event;
    //   });
    // }).onError((error){
    //   setState(() {
    //     lastNumber = -1;
    //   });
    // });

    // super.initState();
    // colorStream = ColorStream();
    // changeColor();
  }

  @override
  void dispose() {
    numberStreamController.close();
    subscription.cancel();
    subscription2.cancel(); // ✅ batalkan listener kedua
    super.dispose(); // ✅ terakhir
  }

  void addRandomNumber() {
    Random random = Random();
    int MyNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(MyNum);
      // numberStream.addError();
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }

  void changeColor() async {
    colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  // await for (var eventColor in colorStream.getColors()) {
  //   setState(() {
  //     bgColor = eventColor;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                lastNumber.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                values, // ✅ Tampilkan deretan angka
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () => addRandomNumber(),
                child: const Text('New Random Number'),
              ),
              ElevatedButton(
                onPressed: () => stopStream(),
                child: const Text('Stop Subscription'),
                // onPressed: () => addRandomNumber(),
                // child: const Text('New Random Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
