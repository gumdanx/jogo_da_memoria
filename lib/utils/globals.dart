import '../models/bird_species.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getScore(String birdName) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(birdName); // Retorna null se não existir.
}

Future<void> saveScore(BirdSpecies bird) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(bird.name, bird.numCorrect);
}
const tropibio = 'assets/images/logo_tropibio.png';
const logos = 'assets/images/logos.png';
const vito = 'assets/images/logo_vito.png';
const editorial = 'assets/images/editorial.png';

List<BirdSpecies> birdSpeciesList = [
  BirdSpecies(
      name: 'Alcatraz',
      image: 'assets/images/alcatraz.png',
      image_easy: 'assets/images/easy/alcatraz.png',
      image_medium: 'assets/images/medium/alcatraz.png',
      image_head: 'assets/images/head/alcatraz.png',
      image_body: 'assets/images/body/alcatraz.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Cagarra',
      image: 'assets/images/cagarra.png',
      image_easy: 'assets/images/easy/cagarra.png',
      image_medium: 'assets/images/medium/cagarra.png',
      image_head: 'assets/images/head/cagarra.png',
      image_body: 'assets/images/body/cagarra.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Fragata',
      image: 'assets/images/fragata.png',
      image_easy: 'assets/images/easy/fragata.png',
      image_medium: 'assets/images/medium/fragata.png',
      image_head: 'assets/images/head/fragata.png',
      image_body: 'assets/images/body/fragata.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Gongon',
      image: 'assets/images/gongon.png',
      image_easy: 'assets/images/easy/gongon.png',
      image_medium: 'assets/images/medium/gongon.png',
      image_head: 'assets/images/head/gongon.png',
      image_body: 'assets/images/body/gongon.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'João Preto',
      image: 'assets/images/joao_preto.png',
      image_easy: 'assets/images/easy/joao_preto.png',
      image_medium: 'assets/images/medium/joao_preto.png',
      image_head: 'assets/images/head/joao_preto.png',
      image_body: 'assets/images/body/joao_preto.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Pedreirinho',
      image: 'assets/images/pedreirinho.png',
      image_easy: 'assets/images/easy/pedreirinho.png',
      image_medium: 'assets/images/medium/pedreirinho.png',
      image_head: 'assets/images/head/pedreirinho.png',
      image_body: 'assets/images/body/pedreirinho.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Pedreiro',
      image: 'assets/images/pedreiro.png',
      image_easy: 'assets/images/easy/pedreiro.png',
      image_medium: 'assets/images/medium/pedreiro.png',
      image_head: 'assets/images/head/pedreiro.png',
      image_body: 'assets/images/body/pedreiro.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Pedreiro Azul',
      image: 'assets/images/pedreiro_azul.png',
      image_easy: 'assets/images/easy/pedreiro_azul.png',
      image_medium: 'assets/images/medium/pedreiro_azul.png',
      image_head: 'assets/images/head/pedreiro_azul.png',
      image_body: 'assets/images/body/pedreiro_azul.png',
      numCorrect: 0),
  BirdSpecies(
      name: 'Rabo de Junco',
      image: 'assets/images/rabo_de_junco.png',
      image_easy: 'assets/images/easy/rabo_de_junco.png',
      image_medium: 'assets/images/medium/rabo_de_junco.png',
      image_head: 'assets/images/head/rabo_de_junco.png',
      image_body: 'assets/images/body/rabo_de_junco.png',
      numCorrect: 0),
];

Future<List<BirdSpecies>> fetchBirdSpeciesList() async {
  List<BirdSpecies> updatedList = [];

  for (var bird in birdSpeciesList) {
    int? score = await getScore(bird.name);
    updatedList.add(BirdSpecies(
      name: bird.name,
      image: bird.image,
      image_easy: bird.image_easy,
      image_medium: bird.image_medium,
      image_head: bird.image_head,
      image_body: bird.image_body,
      numCorrect: score ?? 0,
    ));
  }

  return updatedList;
}
