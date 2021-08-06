import 'package:flutter/material.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class EJournal extends StatefulWidget {
  @override
  _EJournalState createState() => _EJournalState();
}

class _EJournalState extends State<EJournal> {
  Future getData() async {
    var url = 'https://portal.mywau.com/dev/flutter/php/ejournal.php';
    var response = await http.post(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: true,
        title: Text('E-Journal', style: headingStyle),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddEditPage(),
          //   ),
          // );
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return ListTile(
                      leading: GestureDetector(
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AddEditPage(
                          //       list: list,
                          //       index: index,
                          //     ),
                          //   ),
                          // );
                          debugPrint('Edit Clicked');
                        },
                      ),
                      title: Text(
                        list[index]['stock'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        list[index]['buy_date'],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: GestureDetector(
                        child: Icon(
                          Icons.delete,
                          color: whiteColor,
                        ),
                        onTap: () {
                          setState(() {
                            var url =
                                'https://portal.mywau.com/dev/flutter/php/delete_ejournal.php';
                            http.post(url, body: {
                              'id': list[index]['id'],
                            });
                          });
                          debugPrint('delete Clicked');
                        },
                      ),
                    );
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
