import 'dart:convert';

import 'package:first_app/models/imagemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Intropage extends StatefulWidget {
  const Intropage({super.key});

  @override
  State<Intropage> createState() => _IntropageState();
}

class _IntropageState extends State<Intropage> {
  List<ImageModel> PostList = [];
  Future<List<ImageModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    var data = jsonDecode(
      response.body.toString(),
    );
    if (response.statusCode == 200) {
      PostList.clear();
      for (Map i in data) {
        PostList.add(ImageModel.fromJson(i as Map<String, dynamic>));
      }
      return PostList;
    } else {
      return PostList;
    }
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
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Text(PostList[index].title.toString());
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
