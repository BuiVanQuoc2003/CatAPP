import 'package:catapp/models/cat.dart';
import 'package:flutter/material.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.cat.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cat.type,
                style: textTheme.titleLarge,
              ),
              Text(
                widget.cat.name,
                style: textTheme.labelLarge,
              ),
              Text(
                widget.cat.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
