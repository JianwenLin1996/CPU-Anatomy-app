import 'package:flutter/material.dart';

class Criteria extends StatefulWidget {
  @override
  _CriteriaState createState() => _CriteriaState();
}

class _CriteriaState extends State<Criteria> {
  Widget criteriaclass(String title, String description) {
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
        title: Text("Consideration of Pipelining"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            ),
            criteriaclass("More Pipelining Stages",
                "The increase in the number of pipeline stages reduces wait time. This is due to the duration of each stages are nearly equal, thus wait time is minimized."),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            ),
            criteriaclass("Latching Delay",
                "Time is needed for pipeline buffers to operate. Thus, instruction cycle time will varied with circuit complexity."),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            ),
            criteriaclass("Conditional Branch",
                "Conditional branch can invalidate several instruction fetches.The figure below shows that EI of Instruction 3 is the conditional branch for Instruction 15. Time will be wasted from unit 9 to 12 as no cycle is being completed at these time."),
            Image.asset("assets/Conditional Branch.png"),
          ],
        ),
      ),
    );
  }
}
