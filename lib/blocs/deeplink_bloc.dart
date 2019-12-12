import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkBloc {

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  StreamSubscription _sub;
  //Adding the listener into contructor
  DeepLinkBloc() {
    //Checking application start by deep link
    startUri().then(_onRedirected);
    //Checking broadcast stream, if deep link was clicked in opened appication
    _sub = getLinksStream().listen(_onRedirected, onError: (err) {
      _onRedirected(err.toString());
    });
  }


  _onRedirected(String uri) {
    stateSink.add(uri);
  }
  
  void dispose() {
    _stateController.close();
  }


  Future<String> startUri() async {
    try {
      return  await getInitialLink();
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}