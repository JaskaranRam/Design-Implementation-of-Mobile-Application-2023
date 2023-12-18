import 'package:dreamy_tales/pages/moral_page.dart';
import 'package:dreamy_tales/pages/story_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlotChoice extends StatefulWidget {
  const PlotChoice({Key? key}) : super(key: key);

  @override
  State<PlotChoice> createState() => _PlotChoiceState();
}

class _PlotChoiceState extends State<PlotChoice> {
  List<Map<String, String>> plots = [
    {'image': 'assets/cappuccettorosso.jpg', 'description': 'Cappuccetto rosso'},
    {'image': 'assets/bellaaddormentata.jpg', 'description': 'La bella addormentata'},
    {'image': 'assets/cenerentola.jpg', 'description': 'Cenerentola'},
    {'image': 'assets/treporcellini.jpg', 'description': 'I 3 porcellini'},

  ];
  String? selectedPlot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moral Choice'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/sfondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: plots.length,
itemBuilder: (context, index) {
  return GestureDetector(
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('plotPreference', plots[index]['description']!);
      setState(() {
        selectedPlot = plots[index]['description'];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You selected ${plots[index]['description']}')),
      );
    },
    child: Column(
      children: [
        Card(
          color: Colors.black.withOpacity(0.6),
          child: Container(
            height: 200, // Aggiungi questa linea per impostare l'altezza del Container
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(plots[index]['image']!),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: selectedPlot == plots[index]['description'] ? Colors.deepPurple : Colors.transparent,
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:10.0),
          child: Text(
            plots[index]['description']!,
            style: TextStyle(
              fontSize: 15.0, 
              fontWeight: FontWeight.bold,
              color: selectedPlot == plots[index]['description'] ? Colors.amber : Colors.white,
              ),
          ),
        ),
      ],
    ),
  );
},
        ),
      )
      ),
      floatingActionButton: selectedPlot != null ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoralChoice()),
          );
        },
        label: Text('Confirm'),
        backgroundColor: Colors.deepPurple,
      ) : null,
    );
  }
}