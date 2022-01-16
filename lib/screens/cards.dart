import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as console;
import 'package:kanban/api/api_client.dart';
import 'package:kanban/settings.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kanban"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'auth/');
                preferences.token = '';
              },
              icon: Icon(
                Icons.logout,
              ))
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: ApiClient().apiCards(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnap) {
              var res = Container(
                child: const CircularProgressIndicator(
                  color: Colors.lightBlue,
                ),
              );
              if (asyncSnap.connectionState == ConnectionState.none &&
                  asyncSnap.hasData == null) {
                res = Container(
                  child: CircularProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                );
              } else if (asyncSnap.connectionState == ConnectionState.done &&
                  asyncSnap.hasData) {
                if (asyncSnap.hasData) {
                  console.log('${asyncSnap}');
                  console.log('${asyncSnap.data}');
                  res = Container(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        ...asyncSnap.data.data
                            .map((card) => ListTile(
                                  leading: Text('${card['row']}'),
                                  title: Text('${card['text']}'),
                                  subtitle: Text('ID: ${card['id']}'),
                                ))
                            .toList()
                      ],
                    )),
                  );
                } else {
                  res = Container(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
              } else if (asyncSnap.hasError) {
                res = Container(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              } else {
                console.log('${asyncSnap}');
                res = Container(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              return res;
            }),
      ),
    );
  }
}
