class BirdSpecies {
  String name;
  String image;
  String image_easy;
  String image_medium;
  String image_head;
  String image_body;
  int numCorrect;

  BirdSpecies({
    required this.name,
    required this.image,
    required this.image_easy,
    required this.image_medium,
    required this.image_head,
    required this.image_body,
    required this.numCorrect
  });

  void incrementCorrect() {
    numCorrect++;
  }
}
