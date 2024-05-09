// Positioned(
//                               top: 50.0,
//                               left: 20.0,
//                               right: 20.0,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.black.withOpacity(0.8),
//                                         borderRadius:
//                                             BorderRadius.circular(25.0),
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 12.0),
//                                       // Search bar
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: TextField(
//                                               style: const TextStyle(
//                                                   color: Colors.white),
//                                               decoration: InputDecoration(
//                                                 hintText: 'Search...',
//                                                 hintStyle: TextStyle(
//                                                     color: Colors.white
//                                                         .withOpacity(1)),
//                                                 border: InputBorder.none,
//                                                 prefixIcon: const Icon(
//                                                   Icons.search,
//                                                   color: Colors.blue,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                                   icon: const Icon(
//                                                     Icons.filter_alt_outlined,
//                                                     color: Colors.blue,
//                                                   ),
//                                                   onPressed: () {
//                                 setState(() {
//                                   pPoints = {};
//                                 });
//                                 dataProvider.pPoints = {};
//                                 dataProvider.polyLineDone = false;

//                                 dataProvider.stateOfCharge = null;
//                                 dataProvider.vehBrand = null;
//                                 dataProvider.vehModel = null;
//                                 dataProvider.showReset = true;
//                               },
//                                                 )
                                             
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),