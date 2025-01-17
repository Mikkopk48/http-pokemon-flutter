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
  int pokemonId = 1; // El primer Pokémon tiene ID = 1
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await Dio().get("https://pokeapi.co/api/v2/pokemon/$pokemonId");
      setState(() {
        pokemon = Pokemon.fromJson(response.data);
      });
    } catch (e) {
      setState(() {
        pokemon = null; // Si ocurre un error, no muestra datos.
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Pokemon ID: $pokemonId'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pokemon_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const CircularProgressIndicator() // Muestra indicador de carga
              else ...[
                Text(
                  pokemon?.name.toUpperCase() ?? "No data",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (pokemon != null)
                  Image.network(
                    pokemon!.sprites.frontDefault,
                    height: 400,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: 'prev',
                      child: const Icon(Icons.navigate_before),
                      onPressed: pokemonId > 1
                          ? () {
                              setState(() {
                                pokemonId--;
                              });
                              getPokemon();
                            }
                          : null,
                    ),
                    FloatingActionButton(
                      heroTag: 'next',
                      child: const Icon(Icons.navigate_next),
                      onPressed: pokemonId < 151 // Límite superior (original: 151 Pokemones)
                          ? () {
                              setState(() {
                                pokemonId++;
                              });
                              getPokemon();
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
