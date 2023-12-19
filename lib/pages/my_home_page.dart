import 'package:dreamy_tales/pages/add_main_character_page.dart';
import 'package:dreamy_tales/pages/add_second_character_page.dart';
import 'package:dreamy_tales/pages/login_register_page.dart';
import 'package:dreamy_tales/pages/settings_story.dart';
import 'package:flutter/material.dart';
import 'package:dreamy_tales/pages/analitics_page.dart';
import 'package:dreamy_tales/pages/myStories.dart';
import 'package:dreamy_tales/pages/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_category.dart';
import 'package:dreamy_tales/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppCategory _currentCategory = AppCategory.home;
  
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
  Future<void> signOut() async {
    await Auth().signOut();
  }
  void _exitApp() {
    Navigator.pop(context); // Chiudi il Drawer
    signOut();
    _logout();
  }

  void _changeCategory(AppCategory category) {
    setState(() {
      _currentCategory = category;
    });
    Navigator.pop(context); // Chiudi il Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        elevation: 10,
      ),
      body: _buildBody(),
      drawer: MyDrawer(
        currentCategory: _currentCategory,
        onCategorySelected: _changeCategory,
        onLogout: _logout,
        onExit: _exitApp,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentCategory) {
    case AppCategory.home:
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/sfondo.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 50.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Main Characters:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.amber,shadows: List.generate(1, (index) => Shadow(color: Colors.black, blurRadius: 10, offset: Offset(1, 1)))),
                  ),
                ],
              ),
            ),
Padding(

  padding: const EdgeInsets.only(left:16.0,top: 45.0),
  child: SizedBox(
  height: 160,
  child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('characters').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return const Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Text("Loading");
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String imagePath = data['gender'] == 'Male' ? 'assets/male.png' : 'assets/female.png';
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 50.0,
              ),
              const SizedBox(height: 10),
              Text(
                data['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList()..add(
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
                         Container(
                    width: 100.0, // Imposta la larghezza del pulsante
                    height: 100.0, // Imposta l'altezza del pulsante
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Imposta il colore del pulsante
                      shape: BoxShape.circle, // Rende il pulsante tondo
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 50.0,
                      ),
                      color: Colors.white, // Imposta il colore dell'icona
                      onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddMainCharacterPage()),
                          );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
              const Text(
                'Add',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
          ),
       ),
      ),
    );
  },
),
),
  ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 45.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Second Characters:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.amber,shadows: List.generate(1, (index) => Shadow(color: Colors.black, blurRadius: 10, offset: Offset(1, 1)))),
                  ),
                ],
              ),
            ),
            Padding(

  padding: const EdgeInsets.only(left:16.0,top: 45.0),
  child: SizedBox(
  height: 160,
  child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('second_characters').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return const Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Text("Loading");
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String imagePath = data['gender'] == 'Male' ? 'assets/male.png' : 'assets/female.png';
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 50.0,
              ),
              const SizedBox(height: 10),
              Text(
                data['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList()..add(
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
                         Container(
                    width: 100.0, // Imposta la larghezza del pulsante
                    height: 100.0, // Imposta l'altezza del pulsante
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Imposta il colore del pulsante
                      shape: BoxShape.circle, // Rende il pulsante tondo
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 50.0,
                      ),
                      color: Colors.white, // Imposta il colore dell'icona
                      onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddSecondCharacterPage()),
                          );
                      },
                    ),
                  ),
              const SizedBox(height: 10),
              const Text(
                'Add',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
          ),
       ),
      ),
    );
  },
),
),
  ),
          Expanded(
            child: Container(), // Questo spinge il pulsante in fondo alla pagina
          ),
          Builder(
            builder: (BuildContext context) {
              return Container(
                width: double.infinity, // Questo rende il pulsante largo quanto la pagina
                height: 60.0, // Imposta l'altezza del pulsante
                decoration: BoxDecoration(
                  color: Colors.amber, // Imposta il colore di sfondo del pulsante
                ),
                child: TextButton.icon(
                  icon: Icon(Icons.star), // Imposta l'icona del pulsante
                  label: Text("Let's start the magic"), // Imposta il testo del pulsante
                  onPressed: () {
                  Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SettingsStoryPage()));
                  },
                ),
              );
            },
          ),
          ], 
        ),
        
      );
      case AppCategory.myStories:
        return MyStories();
      case AppCategory.analytics:
        return Analytics();
      case AppCategory.settings:
        return SettingsScreen();
      default:
        return Container();
    }
  }
}

class MyDrawer extends StatelessWidget {
  final AppCategory currentCategory;
  final void Function(AppCategory) onCategorySelected;
  final void Function() onLogout;
  final void Function() onExit;

  MyDrawer({
    required this.currentCategory,
    required this.onCategorySelected,
    required this.onLogout,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.withOpacity(0.9),
              Colors.deepPurple.withOpacity(0.7),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple.withOpacity(0.9),
                    Colors.deepPurple.withOpacity(0.7),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple.withOpacity(0.9),
                      Colors.deepPurple.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String? name = snapshot.data?.getString('name');
                      return Text(
                        'Welcome back, ${name ?? 'Guest'}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(); // mostra un indicatore di caricamento mentre attende
                    }
                  },
                ),
              ),
            ),
            _buildDrawerButton('Home', AppCategory.home, Icons.home),
            _buildDrawerButton('My Stories', AppCategory.myStories, FontAwesomeIcons.book),
            _buildDrawerButton('Analytics', AppCategory.analytics, FontAwesomeIcons.chartBar),
            _buildDrawerButton('Settings', AppCategory.settings, FontAwesomeIcons.gear),
            _buildDrawerButton('EXIT', AppCategory.logout, Icons.exit_to_app, onPressed: onExit),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerButton(String title, AppCategory category, IconData icon, {void Function()? onPressed}) {
    final isSelected = currentCategory == category;
    final tileColor = isSelected ? Colors.deepPurple.withOpacity(0.4) : Colors.transparent;

    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        } else {
          onCategorySelected(category);
        }
      },
      child: Container(
        color: tileColor,
        child: ListTile(
          title: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.deepPurple,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
