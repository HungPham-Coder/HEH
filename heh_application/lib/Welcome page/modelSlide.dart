class Slide {
  final String imageURL;
  final String title;
  final String description;

  Slide(
      {required this.imageURL, required this.title, required this.description});
}

final slideList = [
  Slide(
      imageURL:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fadvise.png?alt=media&token=73296749-85c7-415c-9287-eb044d23d6a1",
      title: "title123",
      description: "description123"),
  Slide(
      imageURL:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fadvise.png?alt=media&token=73296749-85c7-415c-9287-eb044d23d6a1",
      title: "title234",
      description: "description321"),
  Slide(
      imageURL:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fadvise.png?alt=media&token=73296749-85c7-415c-9287-eb044d23d6a1",
      title: "title356",
      description: "description213"),
];
