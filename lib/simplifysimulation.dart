import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

class Simplifysimulation extends StatefulWidget {
  @override
  _SimplifysimulationState createState() => _SimplifysimulationState();
}

class _SimplifysimulationState extends State<Simplifysimulation> {
  FlareController _dataflowController;
  String dataanimation = "None";
  bool running = false;
  int col = 0XFF81C784;

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  Widget button (String name, String animation){
    
    return RaisedButton(
                      color: Color(col),
                      child: Text(name),
                      onPressed: () => setState(() {
                            if (running == false) {
                              dataanimation = animation;
                              running = true;
                              col = 0xFFFFFFFF;

                              Future.delayed(
                                  const Duration(seconds: 11), () {
                                setState(() {
                                  running = false;
                                  col = 0xFF81C784;
                                  dataanimation = " ";
                                });
                              });
                            }
                          }),
                    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
    height: 50.0,
    color: Colors.white,
  ),
      appBar: AppBar(title: Text("Data Flow")),
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  color: Colors.amberAccent[100],
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: FlareActor(
                    "assets/DataFlow.flr",
                    controller: _dataflowController,
                    animation: dataanimation,
                  ),
                ),
                Column(
                  children: <Widget>[
                    button("Fetch", "Fetch cycle"),
                    button("Indirect", "Indirect cycle"),
                   button ("Interrupt", "Interrupt cycle"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
