import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Chapter4 extends StatefulWidget {
  const Chapter4({Key? key}) : super(key: key);

  @override
  State<Chapter4> createState() => _Chapter4State();
}

class _Chapter4State extends State<Chapter4> {
  var data;
  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){
      data= jsonDecode(response.body.toString());
      //  return getUserApi();
    }
    else{
    //  return getUserApi();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter 4'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Text('Loading');
                  }
                  else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context ,index ){
                          return Card(
                            child: Column(
                              children: [
                                      ReuseableRow(title: 'name', value: data[index]['name'].toString()),
                                ReuseableRow(title: 'Username',value: data[index]['username'].toString()),
                              ],
                            ),
                          );
                        });
                  }

                },
              )

          )
        ],
      )
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
      );
  }
}
