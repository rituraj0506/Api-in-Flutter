import 'dart:convert';
import 'package:first_app/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  List<PostModel> PostList = [];
  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    var data = jsonDecode(
      response.body.toString(),
    );
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        PostList.add(
          PostModel.fromJson(i),
        );
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
    return Card(
      child: Container(
        width: screnWidth,
        height: screnHeight,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading");
                    else {
                      return ListView.builder(
                        itemCount: PostList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("user Id"),
                                Text(PostList[index].userId.toString()),
                                Text("tilte"),
                                Text(PostList[index].title.toString()),
                                Text("body"),
                                Text(PostList[index].body.toString()),
                              ],
                            ),
                           
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
