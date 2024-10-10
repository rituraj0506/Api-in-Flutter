import 'dart:convert';
import 'package:first_app/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Productpage extends StatefulWidget {
  const Productpage({super.key});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  // Future<ProductModel> getProductApi() async {
  //   final response = await http.get(
  //      Uri.parse(
  //         'https://webhook.site/6a705349-981b-47ad-b025-be42b7a4e328'),
  //   );
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     return ProductModel.fromJson(data);
  //   }
  //   else
  //   return ProductModel.fromJson(data);
  // }

  Future<ProductModel> getProductApi() async {
    final response = await http.get(
      Uri.parse('https://webhook.site/6a705349-981b-47ad-b025-be42b7a4e328'),
    );
    //  print(response.body);
    print("API Response: ${response.body}");

    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200)
      return ProductModel.fromJson(data);
    else
      throw Exception('Failed to load product');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<ProductModel>(
            future: getProductApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          child: ListView.builder(
                            itemCount:
                                snapshot.data!.data![index].images!.length,
                            itemBuilder: (context, position) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data!.data![index]
                                        .images![position].url
                                        .toString(),
                                  ),
                                )),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                return Text("Loading");
              }
            },
          ),
        ),
      ],
    );
  }
}
