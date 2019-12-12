import 'package:flutter/material.dart';
import 'package:flutter_deeplink_example/blocs/deeplink_bloc.dart';

class DeepLinkScreen extends StatefulWidget {
  @override
  _DeepLinkScreenState createState() => _DeepLinkScreenState();
}

class _DeepLinkScreenState extends State<DeepLinkScreen> {

  DeepLinkBloc _bloc;

  @override
  void initState() {
    _bloc = DeepLinkBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<String>(
        stream: _bloc.state,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Text('No deep link was used  ')
              )
            );
          } else {
            return Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Redirected: ${snapshot.data}')
                )
              )
            );
          }
        },
      ),
    );
  }
}