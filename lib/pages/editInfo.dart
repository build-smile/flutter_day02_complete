import 'package:flutter/material.dart';
import 'package:flutter_day2_complete/utils/localData.dart';
import 'package:intl/intl.dart';

import '../models/Info.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({Key? key}) : super(key: key);

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  Info info = Info();
  var _keyform = GlobalKey<FormState>();
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    info = ModalRoute.of(context)!.settings.arguments as Info;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Info'),
      ),
      body: Container(
        child: Form(
            key: _keyform,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    'Info',
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    initialValue: info.name,
                    validator: _validateString,
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (String? value) {
                      info.name = value!;
                    },
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    initialValue: info.position,
                    onSaved: (String? value) {
                      info.position = value!;
                    },
                    validator: _validateString,
                    decoration: InputDecoration(labelText: 'Position'),
                  ),
                ),
                ListTile(
                    leading: Text('Birthday'),
                    title: TextButton(
                      onPressed: selectDate,
                      child: Text(info.birthday),
                    )),
                ListTile(
                  title: ElevatedButton(
                    onPressed: _submit,
                    child: Text('Submit'),
                  ),
                )
              ],
            )),
      ),
    );
  }

  selectDate() async {
    DateTime firstDate = DateTime(DateTime.now().year - 100);
    DateTime endDate = DateTime.now();
    DateTime birthday = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: firstDate,
          lastDate: endDate,
        ) ??
        DateTime.now();
    info.birthday = DateFormat.yMMMMEEEEd().format(birthday);
    setState(() {});
  }

  _submit() async {
    if (_keyform.currentState!.validate()) {
      _keyform.currentState!.save();
      if (await _storeData()) {
        print('complete');
        Navigator.pop(context);
      }
    }
  }

  Future<bool> _storeData() async {
    LocalData localData = LocalData();
    bool isSave = await localData.setString(key: 'name', value: info.name);
    isSave = await localData.setString(key: 'position', value: info.position);
    isSave = await localData.setString(key: 'birthday', value: info.birthday);
    return isSave;
  }

  String? _validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill data';
    }
    return null;
  }
}
