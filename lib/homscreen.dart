// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HomeScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _signOut(BuildContext context) async {
//     await _auth.signOut();
//     // After sign out, navigate back to the sign-in screen
//     Navigator.pushReplacementNamed(context, '/signin');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () => _signOut(context),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Welcome to Park.io!',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Serif',
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add navigation to other screens if needed
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue, // background color
//                   foregroundColor: Colors.white, // text color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 24.0, vertical: 12.0),
//                   child: Text(
//                     'Go to Parking',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFindingParking = false;
  bool _parkingFound = false;

  void _findParkingSpot() async {
    setState(() {
      _isFindingParking = true;
    });

    // Simulate finding a parking spot
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _parkingFound = true;
      _isFindingParking = false;
    });
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Park.io'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isFindingParking
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : _parkingFound
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_parking,
                          color: Colors.white,
                          size: 80,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Found Parking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                          ),
                        ),
                        SizedBox(height: 10),
                        LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Finding optimal route',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _findParkingSpot,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[850], // background color
                        foregroundColor: Colors.white, // text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        child: Text(
                          'Find Parking Spot',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
