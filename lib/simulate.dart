import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

/*void main()  {
   runApp(new MaterialApp(
        home: new Simulate(),
      ));
}*/

class Simulate extends StatefulWidget {
  @override
  _SimulateState createState() => _SimulateState();
}

class _SimulateState extends State<Simulate> {
  FlareController _cpuController;
  String currentanimation = "None";

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

  int error = 0;
  bool _running = false;
  int stage = 0;
  List<String> register = ["00000000", "00000000", "00000000", "00000000"];
  List<String> opcode = ["0000", "0001", "0010", "0011"];
  List<String> opcodeValue = ["0000", "0000", "0000", "0000"];
  List<String> ram = [
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "1000",
    "1001",
    "1010",
    "1011",
    "1100",
    "1101",
    "1110",
    "1111"
  ];

  List<String> ram0to15 = [
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000",
    "00000000"
  ];

  List<String> ramValue = ["0000", "0000", "0000", "0000"];

  int binarydecode(String binary) {
    switch (binary) {
      case "0000":
        return 0;
      case "0001":
        return 1;
      case "0010":
        return 2;
      case "0011":
        return 3;
      case "0100":
        return 4;
      case "0101":
        return 5;
      case "0110":
        return 6;
      case "0111":
        return 7;
      case "1000":
        return 8;
      case "1001":
        return 9;
      case "1010":
        return 10;
      case "1011":
        return 11;
      case "1100":
        return 12;
      case "1101":
        return 13;
      case "1110":
        return 14;
      case "1111":
        return 15;
      default:
        return 0;
    }
  }

  Widget otherram(int number) {
    return Container(
      color: number % 2 == 0 ? Colors.purpleAccent[100] : null,
      child: Row(
        children: <Widget>[
          new Text(
            "RAM" + "$number".padLeft(2) + " ",
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w800),
          ),
          DropdownButton<String>(
            items: ram.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(fontSize: 10.0),
                ),
              );
            }).toList(),
            value: this.ram0to15[number].substring(0, 4),
            onChanged: (String newSelectedValue) {
              setState(
                () {
                  ram0to15[number] =
                      ram0to15[number].replaceRange(0, 4, newSelectedValue);
                },
              );
            },
          ),
          DropdownButton<String>(
            items: ram.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(fontSize: 10.0),
                ),
              );
            }).toList(),
            value: this.ram0to15[number].substring(4),
            onChanged: (String newSelectedValue) {
              setState(
                () {
                  ram0to15[number] =
                      ram0to15[number].replaceRange(4, 8, newSelectedValue);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget ramrow(int a, int b, int c) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          otherram(a),
          otherram(b),
          otherram(c),
        ]);
  }

  Widget ram4to15() {
    return Column(
      children: <Widget>[
        ramrow(4, 5, 6),
        ramrow(7, 8, 9),
        ramrow(10, 11, 12),
        ramrow(13, 14, 15)
      ],
    );
  }

  Widget insertRAM(int number) {
    return Container(
      color: number % 2 == 1 ? Colors.lightBlueAccent[100] : Colors.white,
      /*width: MediaQuery.of(context).size.width/4,
      height:55.0,*/
      child: Column(
        children: <Widget>[
          new Text("RAM $number",
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)),
          Row(
            children: <Widget>[
              DropdownButton<String>(
                items: opcode.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(
                      dropDownStringItem,
                      style: TextStyle(fontSize: 10.0),
                    ),
                  );
                }).toList(),
                value: opcodeValue[number],
                onChanged: (String newSelectedValue) {
                  setState(
                    () {
                      this.opcodeValue[number] = newSelectedValue;
                      ram0to15[number] =
                          ram0to15[number].replaceRange(0, 4, newSelectedValue);
                    },
                  );
                },
              ),
              DropdownButton<String>(
                items: (opcodeValue[number] == "0011" &&
                        ramValue[number] != "0000" &&
                        ramValue[number] != "0001" &&
                        ramValue[number] != "0010" &&
                        ramValue[number] != "0011")
                    ? ram.sublist(4).map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: TextStyle(fontSize: 10.0),
                          ),
                        );
                      }).toList()
                    : ram.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: TextStyle(fontSize: 10.0),
                          ),
                        );
                      }).toList(),
                value: ramValue[number],
                onChanged: (String newSelectedValue) {
                  setState(
                    () {
                      this.ramValue[number] = newSelectedValue;
                      ram0to15[number] =
                          ram0to15[number].replaceRange(4, 8, newSelectedValue);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _run(String opcodeValue, String ramValue) {
    setState(() {
      stage++;
      _running = true;
    });
    if (opcodeValue == "0000") //opcode 0000
      opcode0000(stage - 1, ramValue, 1); //1 here means to register 1
    else if (opcodeValue == "0001") //opcode 0001
      opcode0000(stage - 1, ramValue,
          2); //2 here means to register 2 (no zero index for RAM to Register)
    else if (opcodeValue == "0010") //opcode 0010
      add(
          stage - 1,
          ramValue.substring(0, 2),
          ramValue.substring(
              2)); //ramValue first 2 bits and second 2 bits represents 2 registers, add and save in second regsiter
    else if (opcodeValue == "0011") updateRAM(stage - 1, ramValue);
    //load register 1 to RAM
  }

  void updateRAM(int st, String ramV) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        currentanimation = "PC";
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        currentanimation = "RAM[$st]";
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        currentanimation = "IR";
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        currentanimation = "Reg to CU[1]";
      });
    });
    Future.delayed(const Duration(milliseconds: 4500), () {
      setState(() {
        int _temp = binarydecode(ramV);
        if (_temp > 3) {
          currentanimation = "RAM[$_temp]";
          ram0to15[_temp] = register[0].padLeft(8, "0");
        }
        if (stage < 4) _running = false;
      });
    });
  }

  void add(int st, String firstreg, String secondreg) {
    int registerfirst = 0;
    int registersecond = 0;
    int result = 0;

    switch (firstreg) {
      case "00":
        registerfirst = 1;
        break;
      case "01":
        registerfirst = 2;
        break;
      case "10":
        registerfirst = 3;
        break;
      case "11":
        registerfirst = 4;
        break;
    }
    switch (secondreg) {
      case "00":
        registersecond = 1;
        break;
      case "01":
        registersecond = 2;
        break;
      case "10":
        registersecond = 3;
        break;
      case "11":
        registersecond = 4;
        break;
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        currentanimation = "PC";
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        currentanimation = "RAM[$st]";
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        currentanimation = "IR";
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        currentanimation = "Reg to CU[$registerfirst]";
      });
    });
    Future.delayed(const Duration(milliseconds: 4500), () {
      setState(() {
        currentanimation = "ALU Input[1]";
      });
    });
    Future.delayed(const Duration(milliseconds: 5500), () {
      setState(() {
        currentanimation = "Reg to CU[$registersecond]";
      });
    });
    Future.delayed(const Duration(milliseconds: 6500), () {
      setState(() {
        currentanimation = "ALU Input[2]";
      });
    });
    Future.delayed(const Duration(milliseconds: 7500), () {
      setState(() {
        currentanimation = "ALU";
        int value1LSV =
            binarydecode(register[registerfirst - 1].toString().substring(4));
        int value1MSV = binarydecode(
            register[registerfirst - 1].toString().substring(0, 4));
        int value2LSV =
            binarydecode(register[registersecond - 1].toString().substring(4));
        int value2MSV = binarydecode(
            register[registersecond - 1].toString().substring(0, 4));
        int value1 = value1MSV * 16 + value1LSV;
        int value2 = value2MSV * 16 + value2LSV;
        error = (value1 + value2) > 256 ? error + 1 : error;

        result = (value1 + value2) > 256 ? 0 : value1 + value2;
      });
    });
    Future.delayed(const Duration(milliseconds: 9000), () {
      setState(() {
        currentanimation = "ALU Output";
      });
    });
    Future.delayed(const Duration(milliseconds: 10000), () {
      setState(() {
        currentanimation = "Temp to Reg[$registersecond]";
      });
    });
    Future.delayed(const Duration(milliseconds: 11000), () {
      setState(() {
        currentanimation = "Reg to CU[$registersecond]";
        register[registersecond - 1] =
            result.toRadixString(2).toString().padLeft(8, "0");

        if (stage < 4) _running = false;
      });
    });
  }

  void opcode0000(int st, String ramV, int toreg) {
    int toram = 0;
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        currentanimation = "PC";
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        currentanimation = "RAM[$st]";
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        currentanimation = "IR";
        toram = binarydecode(ramV);
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        currentanimation = "RAM[$toram]";
      });
    });
    Future.delayed(const Duration(milliseconds: 4500), () {
      setState(() {
        currentanimation = "RAM to Reg[$toreg]";

        register[toreg - 1] =
            ram0to15[binarydecode(ramV)]; // register[] is zero index
        if (stage < 4) _running = false;
      });
    });
  }

  void refresh() {
    setState(() {
      _running = false;
      stage = 0;
      error = 0;
      for (int i = 0; i < 4; i++) {
        register[i] = "00000000";
        opcodeValue[i] = "0000";
        ramValue[i] = "0000";
      }

      for (int j = 0; j < 12; j++) {
        ram0to15[j] = "00000000";
      }
    });
  }

  Future _instruction() async {
    await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text("Instruction Set"),
          children: <Widget>[Image.asset("assets/Instruction.png")],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.white,
      ),
      appBar: new AppBar(
        elevation: 5.0,
        backgroundColor: Colors.grey,
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.book),
            onTap: () => {_instruction()},
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          ),
          GestureDetector(
            child: Icon(Icons.refresh),
            onTap: () => {refresh()},
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          ),
          GestureDetector(
            child: new Row(
              children: <Widget>[
                new Text(
                  "Run",
                  style: TextStyle(fontSize: 25.0),
                ),
                new Icon(
                  Icons.directions_run,
                  size: 25.0,
                )
              ],
            ),
            onTap: _running
                ? null
                : () => _run(opcodeValue[stage], ramValue[stage]),
          )
        ],
        title: new Text(
          "Simulate",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30.0),
        ),
      ),
      body: ListView(children: <Widget>[
        new Container(
            child: new Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width - 120,
                    height: 250.0,
                    child: new FlareActor(
                      "assets/CPU.flr",
                      controller: _cpuController,
                      animation: currentanimation,
                    )),
                Column(
                  children: <Widget>[
                    new Text("RAM0  = ${ram0to15[0]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM1  = ${ram0to15[1]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM2  = ${ram0to15[2]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM3  = ${ram0to15[3]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM4  = ${ram0to15[4]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM5  = ${ram0to15[5]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM6  = ${ram0to15[6]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM7  = ${ram0to15[7]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM8  = ${ram0to15[8]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM9  = ${ram0to15[9]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM10 = ${ram0to15[10]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM11 = ${ram0to15[11]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM12 = ${ram0to15[12]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM13 = ${ram0to15[13]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM14 = ${ram0to15[14]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("RAM15 = ${ram0to15[15]}",
                        style: TextStyle(fontSize: 10.0)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    ),
                    new Text("R1 = ${register[0]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("R2 = ${register[1]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("R3 = ${register[2]}",
                        style: TextStyle(fontSize: 10.0)),
                    new Text("R4 = ${register[3]}",
                        style: TextStyle(fontSize: 10.0)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    ),
                    new Text("PC = $stage", style: TextStyle(fontSize: 10.0)),
                    new Text("Overflow = $error",
                        style: TextStyle(fontSize: 10.0)),
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                insertRAM(0),
                insertRAM(1),
                insertRAM(2),
                insertRAM(3)
              ],
            ),
            Row(
              children: <Widget>[ram4to15()],
            )
          ],
        ))),
      ]),
    );
  }
}
