import 'package:flutter/material.dart';

import '../models/Info.dart';
import '../utils/localData.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _getInfo(),
            builder: (BuildContext context, AsyncSnapshot<Info> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name: ${snapshot.data!.name}',
                      style: textStyle,
                    ),
                    Text(
                      'Position: ${snapshot.data!.position}',
                      style: textStyle,
                    ),
                    Text(
                      'Birthday: ${snapshot.data!.birthday}',
                      style: textStyle,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit_info',
                                  arguments: snapshot.data)
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Icon(Icons.edit))
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<Info> _getInfo() async {
    LocalData localData = LocalData();
    Info info = Info();
    info.name = await localData.getString('name') ?? '';
    info.position = await localData.getString('position') ?? '';
    info.birthday = await localData.getString('birthday') ?? '';

    return info;
  }
}
