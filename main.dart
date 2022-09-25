import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class Tabels {
  final int tableCount;
  List proudect = [];
  Tabels(this.tableCount, this.proudect);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Stateful Clicker Counter',
      theme: ThemeData(
        // Application theme data, you can set the colors for the application as
        // you want
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Clicker Counter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Prod> _prod = [];
  List<Tabels> _tabels = [];
  int counter = 1;
  void _add() {
    setState(() {
      _tabels.add(Tabels(counter, []));
      counter++;
      print(_tabels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.red),
        body: Center(
            child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _tabels.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          subtitle: Text(
                            "Tabel ${_tabels[index].tableCount}",
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Commends(content: _tabels[index])));
                          }),
                    );
                  })),
          Row(children: [
            RaisedButton(child: Text("Add tabel"), onPressed: _add),
            SizedBox(),
            RaisedButton(
              child: Text("delet table"),
              onPressed: () {
                setState(() {
                  _tabels.removeLast();
                  counter--;
                });
              },
            )
          ])
        ])));
  }
}

class Commends extends StatefulWidget {
  final Tabels content;

  const Commends({Key? key, required this.content}) : super(key: key);

  @override
  State<Commends> createState() => _CommendsState();
}

class _CommendsState extends State<Commends> {
  @override
  void initState() {
    names = jjstr;
    prices = gjstr;
    jstr1();
    super.initState();
  }

  @override
  late List<Prod> _prod = [];
  List prod0 = [];
  late List<String> names = jjstr;
  late List<String> prices = gjstr;
  List<String> jjstr = [];
  List<String> gjstr = [];

  void _adds(name, price, nim) {
    _prod.add(Prod(name, price, nim));
  }

  void talabat(prods) {
    if (widget.content.proudect.contains(prods)) {
      setState(() {
        prods.number++;
      });
    } else {
      setState(() {
        widget.content.proudect.add(prods);
      });
    }
  }

  late String name;
  var price;
  var number;
  jstr() async {
    final s = await SharedPreferences.getInstance();
    s.setStringList("s", names);
    s.setStringList("z", prices);
  }

  jstr1() async {
    final s = await SharedPreferences.getInstance();
    jjstr = s.getStringList("s") ?? [];
    gjstr = s.getStringList("z") ?? [];
    names = jjstr;
    prices = gjstr;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("commends"),
            ),
            body: Center(
                child: Column(
              children: [
                SizedBox(
                    height: 300,
                    width: 300,
                    child: Expanded(
                        child: ListView.builder(
                            itemCount: _prod.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: ListTile(
                                      subtitle: Text(jjstr[index]),
                                      onTap: () => talabat(_prod[index])));
                            }))),
                Container(
                    height: 200,
                    width: 300,
                    child: Expanded(
                        child: ListView.builder(
                      itemCount: widget.content.proudect.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                "${widget.content.proudect[index].name} ${widget.content.proudect[index].number}"),
                          ),
                        );
                      },
                    ))),
                RaisedButton(onPressed: () {
                  Navigator.pop(context);
                }),
              ],
            )),
            floatingActionButton: FloatingActionButton(onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(title: Text("add "), actions: [
                        TextField(onChanged: (text) {
                          name = text;
                        }),
                        TextField(onChanged: (text1) {
                          price = text1;
                        }),
                        RaisedButton(onPressed: () {
                          setState(() {
                            jstr();
                            jstr1();
                            names.add(name);
                            prices.add(price);
                            _prod = List.generate(
                                jjstr.length,
                                (index) => Prod(
                                    jjstr[index], int.parse(gjstr[index]), 0));
                          });
                        }),
                      ]);
                    });
              });
            })));
  }
}

class Prod {
  late String name;
  late int price;
  var number = 0;
  Prod(this.name, this.price, this.number);
}
