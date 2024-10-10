import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// without creating model

class Imagepage extends StatefulWidget {
  const Imagepage({super.key});

  @override
  State<Imagepage> createState() => _ImagepageState();
}

class _ImagepageState extends State<Imagepage> {
  List<Map<String, dynamic>> PostList = [];
  Future<List<Map<String, dynamic>>> getImage() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        PostList.add(i);
      }
      return PostList;
    } else {
      return PostList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: PostList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text(PostList[index]['title']),
                              Image.network(PostList[index]['url']),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}







// using dyanmic 

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ImagePage extends StatefulWidget {
//   const ImagePage({super.key});

//   @override
//   State<ImagePage> createState() => _ImagePageState();
// }

// class _ImagePageState extends State<ImagePage> {
//   List<dynamic> postList = [];

//   Future<void> getImage() async {
//     final response = await http
//         .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
//     if (response.statusCode == 200) {
//       postList = jsonDecode(response.body);
//       setState(() {}); // Refresh the UI
//     } else {
//       // Handle the error
//       print('Failed to load images');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getImage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image List'),
//       ),
//       body: postList.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: postList.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Column(
//                     children: [
//                       Text(postList[index]['title']),
//                       Image.network(postList[index]['thumbnailUrl']),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
