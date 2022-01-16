import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kanban/api/api_client.dart';
import 'package:kanban/settings.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:developer' as console;

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kanban"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Form(
            key: this._formKey,
            child: ListView(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    return (value!.length < 4) ? 'Minimum is 4 characters' : null;
                  },
                  onChanged: (value){
                    username = value;
                  },
                ).padding(all: 10),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    return (value!.length < 8) ? 'Minimum is 8 characters' : null;
                  },
                  onChanged: (value){
                    password = value;
                  },
                ).padding(all: 10),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child:  ElevatedButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      if (this._formKey.currentState!.validate()) {
                        console.log('valid');
                        try {
                          var request = await ApiClient().apiAuth(username,
                              password);
                          console.log('${request.statusCode}');
                          console.log('${request.data}');
                          if (request.statusCode == 200) {
                            preferences.token = request.data['token'];
                            console.log('${preferences.token}');
                            Navigator.pushReplacementNamed(context, 'cardsB/');
                            // Navigator.pushReplacementNamed(context, 'cards/');
                          }
                        } on DioError catch (e) {
                          console.log('${e.message}');
                          _errorDialog('${Exception(e.response?.data)}');
                          throw Exception(e.response?.data);
                        }
                      }

                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    // onPressed: this.submit,
                  ),
                  margin: const EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _errorDialog(String exception){
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Error"),
          content: Text("${exception}"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
                child: Text("Ок"),
                onPressed: ()
                {
                  Navigator.of(context).pop();
                }
            ),
          ],
        );
      },
    );
  }
}
