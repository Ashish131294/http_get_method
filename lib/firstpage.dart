import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {

  Map<String, dynamic>? m;
  bool getdata = false;
  currency? myclass;


  @override
  void initState() {
    super.initState();
    get();
  }


  get() async {
    try {
      var url = Uri.https('dwija.000webhostapp.com', 'change.php');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Map<String, dynamic> m = jsonDecode(response.body);
      myclass = currency.fromJson(m);
      
      setState(() {
        getdata=true;
      });

      print(m);
    } catch (e) {
      print(e);
    }
  }
  
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: getdata?Column(
        children: [
          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          TextField(
            controller: t3,
          ),
          ElevatedButton(
              onPressed: () {
                String amount = t1.text;
                String from = t2.text;
                String to = t3.text;
              },
              child: Text("Submit")),
          Text("${myclass!.result}")
        ],
      ):Text("Loading..."),
    );
  }
}

class currency {
  bool? success;
  Query? query;
  Info? info;
  double? result;

  currency({this.success, this.query, this.info, this.result});

  currency.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['result'] = this.result;
    return data;
  }
}

class Query {
  String? from;
  String? to;
  int? amount;

  Query({this.from, this.to, this.amount});

  Query.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['amount'] = this.amount;
    return data;
  }
}

class Info {
  int? timestamp;
  double? quote;

  Info({this.timestamp, this.quote});

  Info.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['quote'] = this.quote;
    return data;
  }
}
