import 'dart:async';
import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/moviematch.pbgrpc.dart';
import 'package:grpc/grpc.dart';


// Koodi on haettu seuraavasta lähteestä: https://pastebin.com/x5sChMiL.
// Luokasta puuttuu tällä hetkellä yhteyden poissiivoaminen:
class MovieMatchProvider extends ChangeNotifier {
  late final ClientChannel _channel;
  late final MovieMatchClient _stub;
  late final StreamController<StateMessage> _send;
  late final ResponseStream<StateMessage> _receive;
  String userName = WordPair.random().join();
  Map<String, String> parsedMatchMsg = {};
  List<Map<String, dynamic>> matchList = [];

  MovieMatchProvider() {
    var isAndroid = Platform.isAndroid;

    // 10.0.2.2 on Android-emulaattorin proxy. Käytettäessä esimerkiksi
    // Windows-sovellusta tai web-clientia vaihdetaan urliksi localhost:
    String baseUrl = isAndroid ? '10.0.2.2' : "localhost";
    _channel = ClientChannel(baseUrl,
        port: 50051,
        options: ChannelOptions(credentials: ChannelCredentials.insecure()));

    _stub = MovieMatchClient(_channel);
    _send = StreamController<StateMessage>();
    _receive = _stub.streamState(_send.stream);

    _receive.listen((msg) {
      // Oma lisäys
      List<String> parts = msg.user.split("|");

      String otherUser = "";

      for (String user in parts) {
        if (user != userName) {
          otherUser = user;
          break;
        }
      }

      // Oma lisäys 18.4.2025
      bool containsUser = false;

      for (int i = 0; i < matchList.length; i++) {
        if (matchList[i]["user"] == otherUser) {
          if (!matchList[i]["data"].contains(msg.data)) {
            matchList[i]["data"]?.add(msg.data);
          } 
          containsUser = true;
          break;
        }
      }

      if (matchList.isEmpty || !containsUser) {
        matchList.add({
          "user": otherUser,
          "data": [msg.data]
        });
      }

      notifyModalBottomSheet({otherUser: msg.data});
    });
  }

  void notifyModalBottomSheet(Map<String, String> match) {
    this.parsedMatchMsg = match;
    notifyListeners();
  }

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void send(movieName) {
    var msg = StateMessage()
      ..data = movieName
      ..user = userName;

    _send.add(msg);
  }
}
