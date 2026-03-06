// ===========================================
// IMPORT: Bring in Flutter's Material Design widgets
// Like borrowing tools from a friend
// ===========================================
import 'package:flutter/material.dart';

// ===========================================
// MAIN FUNCTION - Where the app starts
// Like the power button on your TV
// ===========================================
void main() {
  // runApp = Flutter command to start the app
  // MyApp() = Create our main widget
  // const = This widget never changes
  runApp(const MyApp());
}

// ===========================================
// MYAPP WIDGET - The root of our app
// StatelessWidget = This widget never changes (like your ID photo)
// ===========================================
class MyApp extends StatelessWidget {
  // Constructor - creates the widget
  const MyApp({super.key});
  // build = This method creates the user interface
  @override
  Widget build(BuildContext context) {
    // MaterialApp = Google-style wrapper for our entire app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title = Name shown when switching between apps
      title: 'Student Info App',

      // theme = Visual styling for the whole app
      theme: ThemeData(
        // MAIN COLOR - changed from blue to green
        primarySwatch: Colors.green,

        // APP BAR THEME - styles all app bars
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white, // Text/icon color
          centerTitle: true,
          elevation: 4, // Shadow depth
        ),

        // BUTTON THEME - styles all elevated buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
            minimumSize: const Size(100, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // TEXT THEME - styles all text
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),

      // home = First screen users see when app opens
      home: const MyHomePage(),
    );
  }
}

// PART 1: WIDGET CLASS - The blueprint
// This class never changes
// ===========================================
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // createState = Flutter calls this to create the state object
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ===========================================
// PART 2: STATE CLASS - Where all changing data lives
// _ (underscore) means private - only used in this file
// ===========================================
class _MyHomePageState extends State<MyHomePage> {
  // ========== STATE VARIABLES ==========
  // These variables CAN change over time
  // String = Text data
  String studentName = "Mpho";

  // Current favorite subject (will change when button pressed)
  String favoriteSubject = "TPG316C";
  // int = Whole number
  int subjectIndex = 0; // Tracks which subject we're on
  // List<String> = Collection of text items
  List<String> subjects = [
    "TPG316C", // Index 0
    "SOD316C", // Index 1
    "CMN316C", // Index 2
    "ITS316C", // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Student Card"),
        // background removed - now using theme as well as centerTitle
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print("Settings pressed");
            },
          ),
        ],
      ),
      // ========== BODY WITH VARIABLES ==========
      body: Center(
        // SingleChildScrollView = Makes content scrollable if it overflows
        child: SingleChildScrollView(
          // Padding = Space around the content (like a margin)
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ), // 20 pixels of padding on all sides
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ===========================================
                // STUDENT INFO CARD - THIS IS WHAT WE WILL EXTRACT
                // ===========================================
                StudentInfoCard(
                  studentName: studentName,
                  favoriteSubject: favoriteSubject,
                ),
                // ===========================================
                // END OF CODE TO EXTRACT
                // ===========================================
                const SizedBox(height: 30),
                // ========== CHANGE SUBJECT BUTTON ==========
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // setState = Tell Flutter "Something changed! Redraw!"
                      setState(() {
                        // Move to next subject, wrap around at end
                        // % = modulo operator (remainder after division)
                        subjectIndex = (subjectIndex + 1) % subjects.length;
                        // Update favoriteSubject with new subject from list
                        favoriteSubject = subjects[subjectIndex];
                      });
                    },
                    child: const Text("Change Subject"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FAB pressed");
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // Get the current theme
  final theme = Theme.of(context);
  return Container(
    color: theme.primaryColor, // Uses theme color (green)
    child: Text(
      "Themed Text",
      style: theme.textTheme.bodyLarge, // Uses theme text style
    ),
  );
}

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({
    super.key,
    required this.studentName,
    required this.favoriteSubject,
  });

  final String studentName;
  final String favoriteSubject;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding = Space INSIDE the container
      padding: const EdgeInsets.all(20),
      // decoration = Visual styling
      decoration: BoxDecoration(
        // color = Background color
        color: Colors.white, // Light blue
        // borderRadius = Rounded corners
        borderRadius: BorderRadius.circular(15),
        // border = Outline around the container
        border: Border.all(
          color: Colors.blue,
          width: 2, // 2 pixels thick
        ),
      ),
      // child = What's inside the container
      child: Column(
        children: [
          // Student Name Text (using state variable)
          Text(
            "Student Name: $studentName",
            style: const TextStyle(fontSize: 24),
          ),
          // SizedBox = Empty space for spacing
          const SizedBox(height: 10),
          // Favorite Subject Text (using state variable)
          Text(
            "Favorite Subject: $favoriteSubject",
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
