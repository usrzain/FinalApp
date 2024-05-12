import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String? chargingStation;
  final int? slotno;
  final String? chrgtype;
  final String? time;
  final int? totalCost;

  DetailScreen(
      {Key? key,
      this.chargingStation,
      this.slotno,
      this.chrgtype,
      this.time,
      this.totalCost})
      : super(key: key);

  Future<void> updateSpecificValue(
      Map<String, dynamic> stationList, String key) async {
    DatabaseReference _databaseReference =
        FirebaseDatabase.instance.ref().child('Locations/$key');
    try {
      Map<String, dynamic> object = stationList[key];
      int newValue = 0;
      if (object['available_slots'] == 0) {
        print('Previous queue  Value  ');
        print(object['queue']);

        newValue = object['queue'] + 1;
        // Update the specific key with the new value
        await _databaseReference.update({'queue': newValue});
        print('New  queue Value-------------------');
        print(newValue);
      } else {
        print('Previous  available_slots Value  ');
        print(object['available_slots']);

        newValue = object['available_slots'] - 1;
        // Update the specific key with the new value
        await _databaseReference.update({'available_slots': newValue});
        print('New available_slots Value-------------------');
        print(newValue);
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OrangeClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 250.0,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          ClipPath(
            clipper: BlackClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width - 230.0,
              height: MediaQuery.of(context).size.height - 250.0,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Material(
              elevation: 30.0,
              color: Colors.black,
              borderRadius: BorderRadius.circular(18.0),
              child: Container(
                width: 320.0,
                height: 330.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18.0)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ClipPath(
                  clipper: ZigZagClipper(),
                  child: Container(
                    width: 330.0,
                    height: 590.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        // Add a border here
                        color: Colors.cyan, // Set border color to blue
                        width: 2, // Set border width to 5 pixels
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/bill.png'))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Invoice Generated',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('Token ID',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Container(
                            width: 300.0,
                            height: 230.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0)),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  title: Text(
                                    '${chargingStation}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  // trailing: Padding(
                                  //   padding: const EdgeInsets.only(top: 0.0),
                                  //   child: Text(
                                  //     '\$1240.00',
                                  //     style: TextStyle(
                                  //         color: Colors.grey,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 15.0),
                                  //   ),
                                  // ),
                                ),
                                Container(
                                  width: 300.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.car_repair_outlined,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                  title: Text(
                                    'Slot Number',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  //
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Text(
                                      '${slotno}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.flash_on_outlined,
                                    color: Colors.blueAccent,
                                    size: 30.0,
                                  ),
                                  title: Text(
                                    'Charge Type',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  //
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Text(
                                      '${chrgtype}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.access_time,
                                    color: Colors.yellowAccent,
                                    size: 30.0,
                                  ),
                                  title: Text(
                                    'Time',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Text(
                                      '${time}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Text(
                            'Total Amount',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Rs ${totalCost} /-',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.indigo[700]),
                          child: Center(
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.indigo[700], fontSize: 12.0),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.indigo[700],
                            ),
                            child: Icon(
                              Icons.save_alt,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                8.0), // Add spacing between FloatingActionButton and Text
                        Text(
                          'Take ScreenShot',
                          style: TextStyle(
                            color: Colors.indigo[700],
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: () => {
                    double lati = Provider.of<chDataProvider>(
                                              context,
                                              listen: false)
                                          .selectedLatitude;
                                      String title =
                                          Provider.of<chDataProvider>(context,
                                                  listen: false)
                                              .selectedStation;
                                      double long = Provider.of<chDataProvider>(
                                              context,
                                              listen: false)
                                          .selectedLongitude;
                                      String key = Provider.of<chDataProvider>(
                                              context,
                                              listen: false)
                                          .selectedKey;
                  },
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border:
                            Border.all(color: Colors.transparent, width: 1.5),
                        color: Colors.green),
                    child: Center(
                      child: Text(
                        'Navigate',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(3.0, size.height - 10.0);

    var firstControlPoint = Offset(23.0, size.height - 40.0);
    var firstEndPoint = Offset(38.0, size.height - 5.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(58.0, size.height - 40.0);
    var secondEndPoint = Offset(75.0, size.height - 5.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(93.0, size.height - 40.0);
    var thirdEndPoint = Offset(110.0, size.height - 5.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    var fourthControlPoint = Offset(128.0, size.height - 40.0);
    var fourthEndPoint = Offset(150.0, size.height - 5.0);
    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
        fourthEndPoint.dx, fourthEndPoint.dy);

    var fifthControlPoint = Offset(168.0, size.height - 40.0);
    var fifthEndPoint = Offset(185.0, size.height - 5.0);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndPoint.dx, fifthEndPoint.dy);

    var sixthControlPoint = Offset(205.0, size.height - 40.0);
    var sixthEndPoint = Offset(220.0, size.height - 5.0);
    path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy,
        sixthEndPoint.dx, sixthEndPoint.dy);

    var sevenControlPoint = Offset(240.0, size.height - 40.0);
    var sevenEndPoint = Offset(255.0, size.height - 5.0);
    path.quadraticBezierTo(sevenControlPoint.dx, sevenControlPoint.dy,
        sevenEndPoint.dx, sevenEndPoint.dy);

    var eightControlPoint = Offset(275.0, size.height - 40.0);
    var eightEndPoint = Offset(290.0, size.height - 5.0);
    path.quadraticBezierTo(eightControlPoint.dx, eightControlPoint.dy,
        eightEndPoint.dx, eightEndPoint.dy);

    var ninthControlPoint = Offset(310.0, size.height - 40.0);
    var ninthEndPoint = Offset(330.0, size.height - 5.0);
    path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy,
        ninthEndPoint.dx, ninthEndPoint.dy);

    path.lineTo(size.width, size.height - 10.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BlackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2, size.height - 50.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OrangeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 250.0, size.height - 50.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
