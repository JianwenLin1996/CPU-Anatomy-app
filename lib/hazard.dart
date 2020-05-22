import 'package:flutter/material.dart';

class Hazard extends StatefulWidget {
  @override
  _HazardState createState() => _HazardState();
}

class _HazardState extends State<Hazard> {
  Widget hazardclass(String title, String description) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
          ),
          Text(
            description,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.white,
      ),
      appBar: AppBar(
        title: Text("Hazards of Pipelining"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            hazardclass("Resource Hazard",
                "\nResource hazard occurs when two or more instructions in a pipeline need the same resource.\n\nIt can be solved by increasing the available resources like having more ports in main memory and more ALU units. "),
            hazardclass("Data Hazard",
                "\nData hazard occurs when there is conflict in accessing an operand location. For example, when an instruction is executed and the result has not been updated into corresponding register, the register with old data is being fetched by another instruction. In this case, the data used by both instructions is not the same. Thus, data hazard happens."),
            hazardclass("Control Hazard",
                "Pipeline makes wrong decision in a branch prediction and brings instructions into the pipeline that must subsequently be discarded.\n\nIt can be solved by\n\n - Multiple streams\n - Prefetch branch target\n - Loop buffer\n - Branch prediction\n - Delayed branch")
          ],
        ),
      ),
    );
  }
}
