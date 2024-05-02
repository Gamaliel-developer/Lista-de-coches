import 'package:coches_lista/src/models/vehicle-Model.dart';
import 'package:coches_lista/src/providers/API-Service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  bool _cargando = false;
  final ApiService _apiService = ApiService();
  int _totalVehicles = 0;
  List<VehicleModel> _vehicles = [];

  @override
  void initState() {
    _fetchVehicles();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        if (_cargando == false) {
          setState(() {
            _cargando = true;
          });
          await _fetchVehicles();
          setState(() {
            _cargando = false;
          });
        }
      }
    });
    super.initState();
  }

  Future<void> _fetchVehicles() async {
    final Map<String, dynamic> result = await _apiService.fetchVehicles();
    final List<VehicleModel> newVehicles = result['vehicles'];
    final int total = result['total'];
    setState(() {
      _vehicles.addAll(newVehicles);
      _totalVehicles = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 130, 36),
        title: const Text(
          "Inventario",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(Icons.no_crash_rounded,
                            color: Color.fromARGB(255, 238, 130, 36)),
                        const SizedBox(width: 10),
                        Text(
                          '($_totalVehicles) Activos',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 33, 33, 33),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 145,
                    color: const Color.fromARGB(255, 238, 130, 36),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  height: 46,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _vehicles.length,
                itemBuilder: (BuildContext context, int i) {
                  final vehicle = _vehicles[i];
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                vehicle.thumbnail!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: const Color.fromARGB(255, 255, 245,
                                        225), // Color de fondo en caso de error
                                    child: const Center(
                                      child: Icon(
                                        Icons.error,
                                        color:
                                            Color.fromARGB(255, 238, 130, 36),
                                      ), // Icono de error
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            right: 3, left: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3.5)),
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 117, 117, 117))),
                                        child: Text(
                                          vehicle.year ?? '',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 117, 117),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        ' ${vehicle.odometerFormated ?? ''}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 117, 117, 117),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        vehicle.brand ?? '',
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 117, 117),
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Text(" "),
                                      Text(
                                        vehicle.model ?? '',
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 117, 117),
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${vehicle.priceFormatted ?? ''} ',
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 33, 33, 33),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        vehicle.currency ?? '',
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 117, 117),
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              right: 10,
                                              left: 160,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                '#',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 238, 130, 36),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                '${vehicle.id ?? ''}',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 117, 117, 117),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
