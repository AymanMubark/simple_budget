import 'package:flutter/material.dart';
import 'package:simple_budget/data/data.dart';
import 'package:simple_budget/helpers/color_helper.dart';
import 'package:simple_budget/models/category_model.dart';
import 'package:simple_budget/screens/category_screen.dart';
import 'package:simple_budget/widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCatgory(Category category, double totalAmounySpent) {
    final double percent =
        (category.maxAmount - totalAmounySpent) / category.maxAmount;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryScreen(
            category: category,
            totalAmounySpent: totalAmounySpent,
            percent:percent,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '\$ ${(category.maxAmount - totalAmounySpent).toStringAsFixed(2)} /\$ ${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                      height: 20,
                      width: barWidth,
                      decoration: BoxDecoration(
                          color: getColor(context, percent),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // floating: true,
            pinned: true,
            forceElevated: true,
            expandedHeight: 100.0,
            leading: IconButton(
              icon: Icon(Icons.settings, size: 30),
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget'),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext contex, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(expenses: weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmounySpent = category.expenses
                      .map<double>((m) => m.cost)
                      .fold(0, (prev, element) => prev + element);
                  return _buildCatgory(category, totalAmounySpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
