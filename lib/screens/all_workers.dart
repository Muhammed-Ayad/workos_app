import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/all_workers_widget.dart';
import '../widgets/drawer_widget.dart';

class AllWorkersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'All worker',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return AllWorkersWidget(
                   userID: snapshot.data.docs[i].data()['id']??'',
                      userName: snapshot.data.docs[i].data()['name']??'',
                      userEmail: snapshot.data.docs[i].data()['email']??'',
                      positionInCompany: snapshot.data.docs[i].data()
                          ['position']??'',
                      phoneNumber:snapshot.data.docs[i].data()['phoneNumber']??'',
                      userImageUrl: snapshot.data.docs[i].data()['userImageUrl']??'',
                    );
                  });
            } else {
              return Center(
                child: Text('No tasks has been uploaded'),
              );
            }
          }
          return Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
