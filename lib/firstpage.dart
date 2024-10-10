// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:first_app/models/shotmodel.dart';
import 'package:http/http.dart' as http;

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  List<ShotModel> postList = [];
  Future<List<ShotModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());
  
    if (response.statusCode == 200) {
      for (Map i in data)
        postList.add(ShotModel.fromJson(i as Map<String, dynamic>));
      return postList;
    } else
      return postList;
  }

  @override
  Widget build(BuildContext context) {
    final screnWidth = MediaQuery.of(context).size.width;
    final screnHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screnWidth,
      height: screnHeight,
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, AsyncSnapshot<List<ShotModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Resuablerow(
                                title: "Name",
                                value: postList[index].name.toString(),
                              ),
                              Resuablerow(
                                title: "email",
                                value: postList[index].email.toString(),
                              ),
                              Resuablerow(
                                title: "address",
                                value: postList[index].address!.city.toString(),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Resuablerow extends StatelessWidget {
  Resuablerow({super.key, required this.title, required this.value});
  String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text(
          //   snapshot.data![index].name.toString(),
          // ),
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
