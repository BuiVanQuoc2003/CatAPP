import 'package:catapp/config/constant.dart';
import 'package:catapp/models/cat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../repository/user_repository.dart';
import '../auth/widget/loading.dart';

class CatDetailScreen extends StatefulWidget {
  const CatDetailScreen({super.key, required this.cat});

  final Cat cat;
  @override
  State<CatDetailScreen> createState() => _CatDetailScreenState();
}

class _CatDetailScreenState extends State<CatDetailScreen> {
  List<Map<String, String>> list = [
    {"title": "Color", "value": "White"},
    {"title": "Height", "value": "28 cm"},
    {"title": "Weight", "value": "12 kg"},
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: _buildImageCat(context),
            ),
            Positioned(
              bottom: 0,
              child: _buildDetailCat(context),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildImageCat(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 5 / 9,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.cat.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildDetailCat(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      height: size.height * 1 / 2,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTypeAndSex(context),
          _buildName(),
          const SizedBox(),
          _buildFake(),
          _buildDescription(),
          _buildButtonFavourite(context)
        ],
      ),
    );
  }

  _buildFake() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var element in list)
          _buildDetail(context, element["title"] ?? "", element["value"] ?? "")
      ],
    );
  }

  _buildDetail(BuildContext context, String title, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  _buildName() {
    return Text(
      widget.cat.name,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  _buildTypeAndSex(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.cat.type,
          style: textTheme.displayMedium?.copyWith(
            color: colorSecondary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          widget.cat.sex == "male" ? Icons.male : Icons.female,
          color: colorSecondary,
          size: 35,
        ),
      ],
    );
  }

  _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                decoration: TextDecoration.underline,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.cat.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  _buildButtonFavourite(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: _addFavorite,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: borderRadius24,
          color: colorSecondary,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
            child: Text(
          "Add to favorite",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        )),
      ),
    );
  }

  _addFavorite() {
    showLoadingDialog();
    UserRepository.instance.addFavorite(widget.cat).then((value) {
      hideLoadingDialog();
      String message = '';
      if (!value) {
        message = 'Add to favorite failed';
      } else {
        message = 'Add to favorite success';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
