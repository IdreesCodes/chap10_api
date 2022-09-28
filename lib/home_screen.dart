import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Models/PostsModel.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <PostsModel> postlist =[];
  Future<List<PostsModel>> getPostApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data =jsonDecode(response.body.toString());

    if (response.statusCode==200)
      {
        for(Map i in data) {
          postlist.add(PostsModel.fromJson(i));
        }
        return postlist;
      }

    else {
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API'),
        ),
        body: Column(
          children: [

            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder:(context, snapshot){
                  if(!snapshot.hasData)
                    {
                      return Text('Loading');
                    }
                  else{
                    return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context , index)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title \n'+postlist[index].title.toString()),
                              Text('body \n'+postlist[index].body.toString()),

                            ],
                          ),
                        ),
                      );
                    }

                    );
                  }
      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
