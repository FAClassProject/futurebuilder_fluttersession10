import 'package:flutter/material.dart';
import 'package:futurebuilder_fluttersession10/streambuilder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Navigator.of(context).
          push(MaterialPageRoute(builder: (context)=> StreamBuilderDemo()));
        }, icon: Icon(Icons.arrow_forward, color: Colors.white,))],

        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
        future: fetchTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Error"),
                Text(snapshot.error.toString())
              ],);
            }
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Data Available"),
                Text(snapshot.data.toString(), style: TextStyle(fontSize: 29),)
              ],);
            }
            return Text('State: ${snapshot.connectionState}');
          }),
      ),
    );
  }
  Future<String> fetchTime()async{
    await Future.delayed(Duration(seconds: 2));
    var date = DateTime.now();
    return 'Current Time ${date.hour}: ${(date.minute).toString().padLeft(2,'0')}: '
        '${(date.second).toString().padLeft(2,'0')}';
  }
}
