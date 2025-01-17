import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_pokemon_flutter/infrastructure/models/pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Pokemon? pokemon;
  int pokemonId = 0;

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    pokemonId++;
    final response = await Dio().get("https://pokeapi.co/api/v2/pokemon/$pokemonId");
    setState(() {
      pokemon = Pokemon.fromJson(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Id: ${pokemonId.toString()}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pokemon?.name ?? "No data"),
            if (pokemon != null)
              Image.network(pokemon!.sprites.frontDefault)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () async {
          if( pokemonId<=  150)await getPokemon();
          
        },
      ),
    );
  }
}
