import 'package:catapp/feature/detail/cat_detail_screen.dart';
import 'package:catapp/models/cat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemFavorite extends StatefulWidget {
  final Cat item;
  const ItemFavorite({super.key, required this.item});

  @override
  State<ItemFavorite> createState() => _ItemFavoriteState();
}

class _ItemFavoriteState extends State<ItemFavorite> {
  _removeFavorite(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove cat out of favorite'),
        content: const Text('Do you want to remove this cat out of favorite?'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          OutlinedButton(
            onPressed: () {
              // xoas sau đó tắt thông báo
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('cats')
                  .doc(id)
                  .delete()
                  .then((value) => Navigator.of(context).pop());
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  _goDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CatDetailScreen(cat: widget.item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: _goDetailPage,
      child: Container(
        margin: const EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(1, 1),
                  blurRadius: 5)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.item.image,
                    height: size.width / 3,
                    width: size.width / 3,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text('Sex: ${widget.item.sex}'),
                        ),
                        Text('Type: ${widget.item.type}'),
                      ],
                    ),
                  ))
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    onPressed: () => _removeFavorite(widget.item.id),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
