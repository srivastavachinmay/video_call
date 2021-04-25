import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'call_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> onJoin() async {
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(channelName: myController.text),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Agora Group Video Calling',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      // backgroundColor: Colors.black,
        backgroundColor: Color(0xffffbae2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Image(
                  //   image: NetworkImage(
                  //       'https://www.agora.io/en/wp-content/uploads/2019/07/agora-symbol-vertical.png'),
                  //   height: MediaQuery.of(context).size.height * 0.17,
                  // ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    'Agora Group Video Call Demo',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Channel Name',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 15),
                        hintText: 'test',
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.black),
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        hoverColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: MaterialButton(
                      onPressed: onJoin,
                      height: 40,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Join',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
