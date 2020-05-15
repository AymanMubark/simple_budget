import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class BarChart extends StatelessWidget {
  final List<double> expenses;
  BarChart({this.expenses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Text(
                'Nov 10, 2019 - Nov 16, 2019',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Bar(
                label: 'Su',
                amountSpent: expenses[0],
                mostExpensive: expenses.reduce(max),
              ),
              Bar(
                label: 'Mo',
                amountSpent: expenses[1],
                mostExpensive: expenses.reduce(max),
              ),
              Bar(
                label: 'Tu',
                amountSpent: expenses[2],
                mostExpensive: expenses.reduce(max),
              ),
              Bar(
                label: 'We',
                amountSpent: expenses[3],
                mostExpensive: expenses.reduce(max),
              ),
              Bar(
                label: 'Th',
                amountSpent: expenses[4],
                mostExpensive: expenses.reduce(max),
              ),
              Bar(
                label: 'Fr',
                amountSpent: expenses[5],
                mostExpensive: expenses.reduce(max),
              ),
              Bar(
                label: 'Sa',
                amountSpent: expenses[6],
                mostExpensive: expenses.reduce(max),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150;

  const Bar({Key key, this.label, this.amountSpent, this.mostExpensive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            '\$ ${amountSpent.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Container(
            height: barHeight,
            width: 18,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            '$label',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
