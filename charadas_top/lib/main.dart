import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charadas Top',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String charada = 'Aperte o botão!';
  bool baixandoCharada = false;

  void alteraCharada() async {
    String novaCharada = ':(';

    setState(() {
      baixandoCharada = true;
    });

    http.Response response = await http.get(
      'https://us-central1-kivson.cloudfunctions.net/charada-aleatoria',
      headers: {'Accept': 'application/json'},
    );

    setState(() {
      baixandoCharada = false;
    });

    Map jsonCharada = json.decode(response.body);
    String pergunta = jsonCharada['pergunta'];
    String resposta = jsonCharada['resposta'];
    novaCharada = pergunta + ' ' + resposta;

    setState(() {
      charada = novaCharada;
    });
  }

  void compartilhaCharada() {
    Share.share(charada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charadas Top'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: compartilhaCharada,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: baixandoCharada
              ? CircularProgressIndicator()
              : Text('$charada', style: Theme.of(context).textTheme.display1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: alteraCharada,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
