import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hridayangam_task/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> pokedex = [];
  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final pokedexAsyncValue = watch(pokedexProvider);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Color _greenColor = const Color(0xff2a9d8f);
    Color _redColor = const Color(0xffe76f51);
    Color _blueColor = const Color(0xff37A5C6);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          top: -50,
          right: -50,
          child: Image.asset(
            'images/pokemon.png',
            width: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        const Positioned(
            top: 100,
            left: 20,
            child: Text(
              'Pokemon',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )),
        Positioned(
          top: 150,
          bottom: 0,
          width: width,
          child: Column(
            children: [
              pokedex != null
                  ? Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.4),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: pokedex.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: InkWell(
                                child: SafeArea(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: (pokedex[index]['type']?[0] ?? "") == "Grass"
                                            ? Colors.greenAccent
                                            : (pokedex[index]['type']?[0]??"") ==
                                                    "Fire"
                                                ? Colors.redAccent
                                                :( pokedex[index]['type']?[0]??"") ==
                                                        "Water"
                                                    ? Colors.blue
                                                    : (pokedex[index]['type']?
                                                                [0]??"") ==
                                                            "Poison"
                                                        ? Colors
                                                            .deepPurpleAccent
                                                        : (pokedex[index]['type']?
                                                                    [0]??"") ==
                                                                "Electric"
                                                            ? Colors.amber
                                                            : (pokedex[index]['type']?
                                                                        [0]??"" )==
                                                                    "Rock"
                                                                ? Colors.grey
                                                                : (pokedex[index]['type']?[0]??"") ==
                                                                        "Ground"
                                                                    ? Colors
                                                                        .brown
                                                                    : (pokedex[index]['type']?[0]??"") ==
                                                                            "Psychic"
                                                                        ? Colors
                                                                            .indigo
                                                                        : (pokedex[index]['type']?[0]??"") ==
                                                                                "Fighting"
                                                                            ? Colors.orange
                                                                            : (pokedex[index]['type']?[0]??"" )== "Bug"
                                                                                ? Colors.lightGreenAccent
                                                                                : (pokedex[index]['type']?[0]??"") == "Ghost"
                                                                                    ? Colors.deepPurple
                                                                                    : (pokedex[index]['type']?[0]??"") == "Normal"
                                                                                        ? Colors.black26
                                                                                        : Colors.pink,
                                        borderRadius: const BorderRadius.all(Radius.circular(25))),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: -10,
                                          right: -10,
                                          child: Image.asset(
                                            'images/pokemon.png',
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: Hero(
                                            tag: index,
                                            child: CachedNetworkImage(
                                                imageUrl: pokedex[index]['img']??'',
                                                height: 100,
                                                fit: BoxFit.fitHeight,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )),
                                          ),
                                        ),
                                        Positioned(
                                          top: 55,
                                          left: 15,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                pokedex[index]['type']?[0]??'',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    shadows: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.blueGrey,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 1.0,
                                                          blurRadius: 15)
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 15,
                                          child: Text(
                                            pokedex[index]['name']??'',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.blueGrey,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 1.0,
                                                      blurRadius: 15)
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailScreen(
                                                heroTag: index,
                                                pokemonDetail: pokedex[index],
                                                color: pokedex[index]['type']
                                                            [0] ==
                                                        "Grass"
                                                    ? Colors.greenAccent
                                                    : pokedex[index]['type'][0] ==
                                                            "Fire"
                                                        ? Colors.redAccent
                                                        : pokedex[index]['type']
                                                                    [0] ==
                                                                "Water"
                                                            ? Colors.blue
                                                            : pokedex[index]['type']
                                                                        [0] ==
                                                                    "Poison"
                                                                ? Colors
                                                                    .deepPurpleAccent
                                                                : pokedex[index]['type'][
                                                                            0] ==
                                                                        "Electric"
                                                                    ? Colors
                                                                        .amber
                                                                    : pokedex[index]['type'][0] ==
                                                                            "Rock"
                                                                        ? Colors
                                                                            .grey
                                                                        : pokedex[index]['type'][0] == "Ground"
                                                                            ? Colors.brown
                                                                            : pokedex[index]['type'][0] == "Psychic"
                                                                                ? Colors.indigo
                                                                                : pokedex[index]['type'][0] == "Fighting"
                                                                                    ? Colors.orange
                                                                                    : pokedex[index]['type'][0] == "Bug"
                                                                                        ? Colors.lightGreenAccent
                                                                                        : pokedex[index]['type'][0] == "Ghost"
                                                                                            ? Colors.deepPurple
                                                                                            : pokedex[index]['type'][0] == "Normal"
                                                                                                ? Colors.white70
                                                                                                : Colors.pink,
                                              )));
                                },
                              ),
                            );
                          }))
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: 150,
            width: width,
          ),
        ),
      ]),
    );
  }

  final pokedexProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
    final url = "https://pokeapi.co/api/v2/pokemon/ditto";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedJsonData = jsonDecode(response.body);
      final pokemonName = decodedJsonData['name'];

      return [
        {
          'name': pokemonName,
        }
      ];
    } else {
      throw Exception('Failed to fetch data');
    }
  });

}
