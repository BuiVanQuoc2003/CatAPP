import 'package:catapp/feature/favorite/widget/item_favorite.dart';
import 'package:catapp/models/cat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('cats')
              .snapshots(),
          builder: (context, snapshot) {
            final list = _getList(snapshot.data);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = list[index];
                  return ItemFavorite(item: item);
                },
                itemCount: list.length,
              ),
            );
          }),
    );
  }

  List<Cat> _getList(QuerySnapshot<Map<String, dynamic>>? data) {
    List<Cat> list = [];
    if (data != null) {
      for (var doc in data.docs) {
        final cat = Cat.fromJson(doc.data());
        list.add(cat);
      }
    }
    return list;
  }
}
