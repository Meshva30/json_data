import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json/data_model.dart';
import 'package:provider/provider.dart';

import 'data_Provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => DataProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider providerT = Provider.of<DataProvider>(context);
    DataProvider providerF = Provider.of<DataProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Json Data',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
          future: rootBundle.loadString('assets/data.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map data = jsonDecode(snapshot.data!);
              providerF.convertToDataModel(data);
              return Center(
                  child: ListView(
                children: [
                  ListTile(
                    title: Column(
                      children: [
                        Text('Total :${providerT.dataModel!.total}'),
                        Text('Skips :${providerT.dataModel!.skip}'),
                        Text('Limit :${providerT.dataModel!.limit}'),
                      ],
                    ),
                  ),
                  ...List.generate(
                    providerT.dataModel!.postList.length,
                    (index) => ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${providerT.dataModel!.postList[index].id}'),
                          Text(
                              '${providerT.dataModel!.postList[index].userId}'),
                        ],
                      ),
                      title: Text(
                        overflow: TextOverflow.ellipsis,
                        providerT.dataModel!.postList[index].title,
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                              overflow: TextOverflow.ellipsis,
                              providerT.dataModel!.postList[index].body),
                          Text(
                              overflow: TextOverflow.ellipsis,
                              '# ${providerT.dataModel!.postList[index].tags.join(',')}'),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              overflow: TextOverflow.ellipsis,
                              'Like: ${providerT.dataModel!.postList[index].reactions.likes.toString()}'),
                          Text(
                              overflow: TextOverflow.ellipsis,
                              'Dislike: ${providerT.dataModel!.postList[index].reactions.dislikes.toString()}'),
                          Text(
                              overflow: TextOverflow.ellipsis,
                              'View: ${providerT.dataModel!.postList[index].views.toString()}')
                        ],
                      ),
                    ),
                  )
                ],
              ));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
