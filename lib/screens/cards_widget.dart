

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanban/bloc/card_bloc.dart';
import 'package:kanban/model/card_response.dart';
import 'dart:developer' as console;

import '../settings.dart';

class CardWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CardWidgetState();
  }
}

class _CardWidgetState extends State<CardWidget>{
  @override
  void initState() {
    super.initState();
    bloc.getCards();
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
        length: 4,
        child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'On hold'),
              Tab(text: 'In Progress'),
              Tab(text: 'Needs review'),
              Tab(text: 'Approved'),
            ],
          ),
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
        body: TabBarView(
          children: [
              // StreamBuilder<CardResponse>(
              //   stream: bloc.cards.stream,
              //   builder: (context, AsyncSnapshot<CardResponse> snapshot) {
              //     if (snapshot.hasData) {
              //       if (snapshot.data!.error != null &&
              //           snapshot.data!.error.length > 0) {
              //         return _buildErrorWidget(snapshot.data!.error);
              //       }
              //       return _buildCardWidget(snapshot.data!.results
              //           .where((element) => element.row == 0));
              //     } else if (snapshot.hasError) {
              //       return _buildErrorWidget('${snapshot.error}');
              //     } else {
              //       return _buildLoadingWidget();
              //     }
              //   },
              // ),
              _streamBuilder(0),
              _streamBuilder(1),
              _streamBuilder(2),
              _streamBuilder(3),

              // Center(child: Text("Car")),
            // Center(child: Text("Transit")),
            // Center(child: Text("Bike"))
          ])

    ));
  }
  _streamBuilder(int param){
    return StreamBuilder<CardResponse>(
      stream: bloc.cards.stream,
      builder: (context, AsyncSnapshot<CardResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error.length > 0) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildCardWidget(snapshot.data!.results
              .where((element) => element.row == param));
        } else if (snapshot.hasError) {
          return _buildErrorWidget('${snapshot.error}');
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildCardWidget(data) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...data.map((card_item)=>
            Card( child: ListTile(
              title: Text('${card_item.text}'),
            ))
            ).toList()
          ],
        ),
      ),
    );
  }


  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading data from API...",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

}