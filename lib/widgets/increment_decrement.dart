import 'package:flutter/material.dart';

class IncrementDecrementWidget extends StatelessWidget {
  dynamic qty;
  final Function() onIncrement, onDecrement;

  IncrementDecrementWidget(this.qty, {this.onIncrement, this.onDecrement});
  @override
  Widget build(BuildContext context){
    return new Container(
        height: 30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all()),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new GestureDetector(
                  onTap:()
                  {
                    onDecrement();
                  },
                  child: new Container(
                    color: Colors.white,
                    child: new Align(
                      alignment: Alignment.topCenter,
                      child: new Text("-", style: new TextStyle(fontSize: 25, color: Colors.black)),
                    ),
                  )
                ),
            ),
            Expanded(
              flex: 1,
              child: new Container(
                color: Colors.green,
                child: new Center(
                  child: Text('${qty}',style: new TextStyle(fontSize: 20, color: Colors.white)),),
              ),
            ),
            Expanded(
              flex: 1,
              child: new GestureDetector(
                onTap: () {
                  onIncrement();
                },
                child: new Container(
                  color: Colors.white,
                  child: new Center( child: new Text("+", style: new TextStyle(fontSize: 20, color: Colors.black))),
                ),
              ),
            ),
          ],
        ));
  }
}
