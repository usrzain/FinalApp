// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:effecient/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:effecient/navBar/colors/colors.dart';
import 'package:effecient/navBar/font.dart';
import 'package:effecient/navBar/navBar.dart';
import 'package:effecient/tab_contents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final User? user;

  //const HomePage({Key? key}) : super(key: key);
  const HomePage({Key? key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectBtn = 0;

  @override
  void initState() {
    chDataProvider localprovider =
        Provider.of<chDataProvider>(context, listen: false);
    print(Provider.of<chDataProvider>(context, listen: false).userName);
    super.initState();
    _tabController = TabController(length: navBtn.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectBtn = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          if (_tabController.index == 0) Tab1Content(),
          if (_tabController.index == 1) Tab2Content(),
          if (_tabController.index == 3) Tab3Content(),
          if (_tabController.index == 4) const Tab4Content(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: navigationBar(),
          ),
        ],
      ),
    );
  }

  AnimatedContainer navigationBar() {
    chDataProvider localprovider =
        Provider.of<chDataProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 20),
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight:
              Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < navBtn.length; i++)
              GestureDetector(
                onTap: i == 2
                    ? null
                    : () {
                        // Disable tap for index 2
                        setState(() => selectBtn = i);
                        _tabController.animateTo(i);
                      },
                child: iconBtn(i, screenWidth),
              ),
          ],
        ),
      ),
    );
  }

  SizedBox iconBtn(int i, double screenWidth) {
    chDataProvider localprovider =
        Provider.of<chDataProvider>(context, listen: false);
    bool isActive = selectBtn == i ? true : false;
    double tabWidth = screenWidth / navBtn.length;

    return SizedBox(
      width: tabWidth,
      child: GestureDetector(
        onTap: i == 2
            ? null
            : () {
                // Disable tap for index 2 (if needed)
                setState(() => selectBtn = i);
                _tabController.animateTo(i);
              },
        child: Stack(
          children: [
            Positioned.fill(
              // Fill the entire SizedBox
              child: Container(
                color: Colors.transparent, // Transparent container
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: FractionalTranslation(
                translation: Offset(0, isActive ? -0.2 : 0),
                child: navBtn[i].iconOrImagePath is IconData
                    ? (i == 2 // Check if id is 2
                        ? Container(
                            // Wrap Icon with Container for sizing
                            width: 16.0, // Set smaller width for id 2
                            height: 16.0, // Set smaller height for id 2
                            child: Center(
                              child: Icon(
                                navBtn[i].iconOrImagePath,
                                color: isActive
                                    ? selectColor
                                    : (i == 2
                                        ? navBtn[i].originalColor
                                        : white),
                              ),
                            ),
                          )
                        : Icon(
                            navBtn[i].iconOrImagePath,
                            color: isActive
                                ? selectColor
                                : (i == 2 ? navBtn[i].originalColor : white),
                          ))
                    : (i == 2 // Check if id is 2
                        ? SizedBox(
                            // Wrap Image.asset with Container for sizing
                            width: 54.0, // Set smaller width for id 2
                            height: 54.0, // Set smaller height for id 2
                            child: Center(
                              child: Image.asset(
                                navBtn[i].iconOrImagePath,
                                color: isActive
                                    ? selectColor
                                    : (i == 2
                                        ? navBtn[i].originalColor
                                        : white),
                              ),
                            ),
                          )
                        : Image.asset(
                            navBtn[i].iconOrImagePath,
                            color: isActive
                                ? selectColor
                                : (i == 2 ? navBtn[i].originalColor : white),
                          )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionalTranslation(
                translation: Offset(
                  0,
                  isActive ? -0.2 : 0,
                ),
                child: Text(
                  navBtn[i].name,
                  style:
                      isActive ? bntText.copyWith(color: selectColor) : bntText,
                ),
              ),
            ),
            if (isActive)
              Positioned(
                top: 4,
                left: 10,
                right: 10,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(4.0), // Adjust radius as needed
                  child: Container(
                    height: 5,
                    color: bgColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0), // Adjust padding as needed
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('This is the next screen!'),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final String title;

  const TabContent({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
