import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Exercise%20Page/category.dart';

import 'package:heh_application/services/call_api.dart';

import '../../models/exercise_model/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SignUpUser signUpUser = SignUpUser(firstName: '123',
    //     lastName: 'abcdef',
    //     phone: '1236548970',
    //     password: '123456789',
    //     email: '',
    //     gender: false,
    //     dob: '2023-03-27T16:56:43.443Z', username: '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Trang chủ",
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)),
        ],
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(child: Text("Bạn đang gặp vấn đề gì?")),
            FutureBuilder<List<CategoryModel>>(
                future: CallAPI().getAllCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String iconName = "";
                        iconName =
                            "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fknee.png?alt=media&token=47fffdae-d388-4215-aff9-239de7988053";

                        return HomeMenu(
                          icon: iconName,
                          text: "${snapshot.data![index].categoryName}",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                        categoryID:
                                            snapshot.data![index].categoryID)));
                          },
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  HomeMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xfff5f6f9)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white)),
              )),
          onPressed: press,
          child: Row(
            children: [
              Image.network(
                icon,
                width: 60,
                height: 60,
              ),
              const SizedBox(
                width: 20,
                height: 10,
              ),
              Expanded(
                  child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Icon(Icons.arrow_forward_sharp),
            ],
          )),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = ['a', 'b']; //danh sach tim kiem
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query, style: const TextStyle(fontSize: 64)),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        });
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
