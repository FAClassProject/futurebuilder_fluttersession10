import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatefulWidget {
  const StreamBuilderDemo({Key? key}) : super(key: key);

  @override
  State<StreamBuilderDemo> createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  int i = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream Builder Class"),),
      body: Center(child:
        StreamBuilder(
          stream: fetchTimer(),
            builder: (context, snapashot){
               if(snapashot.connectionState == ConnectionState.waiting){
                 return CircularProgressIndicator();
               }
               if(snapashot.hasError){
                 return Column(children: [
                   Text("Error"),
                   Text(snapashot.error.toString())
                 ],);
               }
               if(snapashot.connectionState == ConnectionState.active){
                 return Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                   Text("Hurray!.....Counting Down",style: TextStyle(fontSize: 30)),
                   Text(snapashot.data.toString(), style: TextStyle(fontSize: 30))
                 ],);
               }
               if(snapashot.connectionState == ConnectionState.done){
                 return Text("Finish", style: TextStyle(fontSize: 30),);
               }
               return Text('State: ${snapashot.connectionState}');
            }),
      ),
    );
  }


  Stream<String> fetchTimer()async*{
    while(i > 0){
      await Future.delayed( Duration(seconds: 1));
      i--;
      yield i.toString();
    }
  }
}
