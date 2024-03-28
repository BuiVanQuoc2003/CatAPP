import 'package:catapp/feature/detail/cat_detail_screen.dart';
import 'package:catapp/models/cat.dart';
import 'package:catapp/repository/cat_repository.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.list});

  final List<Cat> list;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  CatRepository catRepository = CatRepository();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await searchCats(widget.list, controller.text);
                        setState(() {});
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Cat>>(
                  future: searchCats(widget.list, controller.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CatDetailScreen(
                                    cat: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(
                              snapshot.data![index].description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data![index].image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Cat>> searchCats(List<Cat> catList, String searchTerm) async {
    if (searchTerm.isEmpty) {
      return [];
    }
    if (catList.isEmpty) {
      catList = await catRepository.listCat();
    }
    searchTerm = searchTerm.toLowerCase();
    return catList
        .where((cat) =>
            cat.name.toLowerCase().contains(searchTerm) ||
            cat.description.toLowerCase().contains(searchTerm))
        .toList();
  }
}
