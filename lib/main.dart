import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 48.0;
  double resultFontSize = 30.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 48.0;
        resultFontSize = 30.0;
      } else if (buttonText == "⨂") {
        equationFontSize = 48.0;
        resultFontSize = 30.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        // equation = "4";
        // expression = "00";

        equationFontSize = 48.0;
        resultFontSize = 30.0;

        expression = equation;
        expression = expression.replaceAll('*', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error ";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      child: Table(
        children: [
          TableRow(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
                color: buttonColor,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid)),
                  padding: EdgeInsets.all(16.0),
                  onPressed: () => buttonPressed(buttonText),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ))
          ]),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TMS_Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                color: Colors.redAccent,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(children: [
                  TableRow(children: [
                    buildButton("C", 1, Colors.redAccent),
                    buildButton("⨂", 1, Colors.orangeAccent),
                    buildButton("÷", 1, Colors.orangeAccent),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.black87),
                    buildButton("8", 1, Colors.black87),
                    buildButton("9", 1, Colors.black87),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.black87),
                    buildButton("5", 1, Colors.black87),
                    buildButton("6", 1, Colors.black87),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.black87),
                    buildButton("2", 1, Colors.black87),
                    buildButton("3", 1, Colors.black87),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.black87),
                    buildButton("0", 1, Colors.black87),
                    buildButton("00", 1, Colors.black87),
                  ]),
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("*", 1, Colors.orangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.orangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.orangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton(
                        "=",
                        2,
                        Colors.redAccent,
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
