import 'package:catapp/config/constant.dart';
import 'package:catapp/feature/detail/cat_detail_screen.dart';
import 'package:catapp/models/cat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CatCardWidget extends StatefulWidget {
  const CatCardWidget({super.key, required this.cat});

  final Cat cat;

  @override
  State<CatCardWidget> createState() => _CatCardWidgetState();
}

class _CatCardWidgetState extends State<CatCardWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        _goToDetail(widget.cat);
      },
      child: Stack(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius16,
                image: DecorationImage(
                  image: NetworkImage(widget.cat.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius16,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        widget.cat.name,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sex: ${widget.cat.sex}",
                                style: textTheme.labelLarge
                                    ?.copyWith(color: Colors.black54),
                              ),
                              Text(
                                "⭐ 4.5",
                                style: textTheme.labelLarge
                                    ?.copyWith(color: Colors.black54),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_outline,
                                color: Colors.red,
                                size: 30,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _goToDetail(Cat cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CatDetailScreen(cat: cat),
      ),
    );
  }
}
