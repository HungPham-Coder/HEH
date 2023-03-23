import 'package:flutter/material.dart';
import 'package:heh_application/Main%20page/Home%20page/View%20Exercise%20Page/detail.dart';

class ViewExercise extends StatefulWidget {
  const ViewExercise({Key? key}) : super(key: key);

  @override
  State<ViewExercise> createState() => _ViewExerciseState();
}

class _ViewExerciseState extends State<ViewExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Bài tập linh hoạt",
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)),
        ],
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailMenu(
              icon: "assets/icons/backache.png",
              text: "Kéo giãn cơ tứ đầu",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExerciseDetail()));
              },
            ),
            DetailMenu(
              icon: "assets/icons/backache.png",
              text: "Kéo giãn cơ gập hông",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExerciseDetail()));
              },
            ),
            DetailMenu(
              icon: "assets/icons/knee.png",
              text: "Kéo giãn cơ khép hông ",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExerciseDetail()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailMenu extends StatelessWidget {
  const DetailMenu({
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Image.asset(
                icon,
                width: 60,
              ),
              const SizedBox(
                width: 20,
                height: 50,
              ),
              Expanded(
                  child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              Column(
                children: <Widget>[
                  IconButton(
                      onPressed: press,
                      icon: Image.asset(
                        "assets/icons/magnifying_glass.png",
                        color: Colors.black,
                      )),
                ],
              )
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
