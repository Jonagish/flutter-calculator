import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.orange),
        ),
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _expression = "";
    } else if (buttonText == "=") {
      try {
        final expression = Expression.parse(_expression);
        final evaluator = const ExpressionEvaluator();
        final result = evaluator.eval(expression, {});
        _output = result.toString();
        _expression += " = " + _output;
      } catch (e) {
        _output = "Error";
      }
    } else {
      if (_expression.contains("=")) {
        _expression = buttonText;
      } else {
        _expression += buttonText;
      }
      _output = _expression;
    }

    setState(() {
      _output = _output;
    });
  }

  Widget _buildButton(String buttonText, Color textColor) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
          side: BorderSide(color: textColor),
          backgroundColor: Colors.black87
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor,),
        ),
        onPressed: () => _buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator - Jonas Genao Abreu', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton("7", Colors.white),
                  _buildButton("8", Colors.white),
                  _buildButton("9", Colors.white),
                  _buildButton("/", Colors.lightGreen),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4", Colors.white),
                  _buildButton("5", Colors.white),
                  _buildButton("6", Colors.white),
                  _buildButton("*", Colors.lightGreen),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1", Colors.white),
                  _buildButton("2", Colors.white),
                  _buildButton("3", Colors.white),
                  _buildButton("-", Colors.lightGreen),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton(".", Colors.white),
                  _buildButton("0", Colors.white),
                  _buildButton("00", Colors.white),
                  _buildButton("+", Colors.lightGreen),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("C", Colors.red),
                  _buildButton("=", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}