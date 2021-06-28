import 'dart:html';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "";
  String record = "";

  void onTap(text) {
    setState(() {
      result += text;
    });
  }

  void clear(){
    setState(() {
      result = "";
      record = "";
    });
  } 

  void evaluate(){
    Parser p = new Parser();
    Expression exp = p.parse(result);
    ContextModel cm = new ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      record = result;
      result = eval.toString();
    });
  }
  Widget button(value) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ButtonTheme(
        minWidth: 0,
        height: 10,
        buttonColor: Colors.black45,
        child: RaisedButton(
          onPressed: () {
            if(value == "C"){
              clear();
            }else if(value == "="){
              evaluate();
            }
            else{
              onTap(value);
            }
          },
          child: Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: Center(child: Text("CALCULATOR", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Text(
              record,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
          ),
          Container(
            child: Text(
              result,
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold,),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button("7"),
              button("8"),
              button("9"),
              button("/"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button("4"),
              button("5"),
              button("6"),
              button("*"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button("1"),
              button("2"),
              button("3"),
              button("+"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button("C"),
              button("0"),
              button("-"),
              button("="),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
