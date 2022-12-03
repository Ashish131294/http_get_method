import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_get_method/firstpage.dart';

void main() {
  runApp(MaterialApp(
    home: firstpage(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  void initState() {
    super.initState();
    get();
  }

  bool getdata = false;
  myclass? Myclass;
  Map<String, dynamic>? m;
  List l = [];

  get() async {
    //get data get
    //post data put
//https://jsonplaceholder.typicode.com/posts
    //https://reqres.in/api/users/2
    /*var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

   */ /*if(response.statusCode==200)
     {
       Map m=jsonDecode(response.body);
       */ /**/ /*Map m1=m['data'];
       print(m1['id']);
       print(m1['email']);
      Map m2=m['support'];
       print(m2['url']);

       */ /**/ /**/ /**/ /*List list=m['data'];
       list.forEach((element) {print(element['title']);});*/ /**/ /*


     }*/
    try {
      var response = await Dio().get('https://reqres.in/api/unkown');
      m = response.data; //map
      Myclass = myclass.fromJson(m!);
      l.add(m);
      setState(() {
        getdata = true;
      });
      print(m);

      /*print(m);
      print(m['page']);
      print(m['per_page']);
      print(m['total']);
      Map m1=m['support'];
      print(m1['url']);*/
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Get Method"),
      ),
      body: getdata
          ? /*Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Text("Page=${Myclass!.page}"),
      Text("PerPage=${Myclass!.perPage}"),
      Text("Total=${Myclass!.total}"),
      Text("Total Pages=${Myclass!.totalPages}"),
      Text("Support=${Myclass!.support!.url}"),
      Text("Support=${Myclass!.support!.text}"),


    ],)*/
          ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                myclass m =myclass.fromJson(l[index]);
                return ListTile(
                  //title: Text("Page=${m!.page}"),
                  title: Text("Page=${m!.page}\nPerpage=${m!.perPage}\nTotal=${m!.total}\nTotalpages=${m!.totalPages}"),
                  subtitle: Text("Data=${m!.data!.length}\nSupport=${m!.support!.url}\n${m!.support!.text}"),

                );
              },
            )
          : Text(""),
    );
  }
}

class myclass {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Data>? data;
  Support? support;

  myclass(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  myclass.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? year;
  String? color;
  String? pantoneValue;

  Data({this.id, this.name, this.year, this.color, this.pantoneValue});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    color = json['color'];
    pantoneValue = json['pantone_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['color'] = this.color;
    data['pantone_value'] = this.pantoneValue;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}
