import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'paises_model.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Coronavirus Track'),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text(
                  'Loading data...',
                  style: TextStyle(fontSize: 22.0),
                ),
              );
            } else {
              Paises pais = snapshot.data[0];
              String totalCases = pais.cases.toString();
              String totalRecovered = pais.recovered.toString();
              String totalDeath = pais.deaths.toString();

              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 70.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.airline_seat_flat,
                                  color: Colors.blue,
                                ),
                                Text(
                                  totalCases,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  'Confirmados',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10.0,),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.airline_seat_legroom_extra,
                                  color: Colors.greenAccent,
                                ),
                                Text(
                                  totalRecovered,
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Text(
                                  'Recuperados',
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10.0,),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.airline_seat_flat_angled,
                                  color: Colors.redAccent,
                                ),
                                Text(
                                  totalDeath,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Text(
                                  'Mortes',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Paises data = snapshot.data[index];

                          return ListTile(
                            title: Text(
                              data.country,
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    data.active.toString(),
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    data.recovered.toString(),
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    data.deaths.toString(),
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
            }
          },
        )));
  }
}

Future<List<Paises>> getData() async {
  String url = "https://coronavirus-19-api.herokuapp.com/countries";

  http.Response response = await http.get(url);

  return paisesFromJson(response.body);
}
