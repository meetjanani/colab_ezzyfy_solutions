// import 'package:colab_ezzyfy_solutions/resource/constant.dart';
// import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// class BottomNavigationPage extends StatefulWidget {
//   BottomNavigationPage({Key? key, required this.currentIndex})
//       : super(key: key);
//   int currentIndex;
//
//   @override
//   State<BottomNavigationPage> createState() => _BottomNavigationPageState();
// }
//
// class _BottomNavigationPageState extends State<BottomNavigationPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // PersistentTabController _controller;
//     // _controller = PersistentTabController(initialIndex: 0);
//
//     List<Widget> _buildScreens = [
//
//     ];
//
//     void onTapped(int index) {
//       setState(() {
//         widget.currentIndex = index;
//       });
//     }
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: greybackColor,
//         body: _buildScreens[widget.currentIndex],
//         bottomNavigationBar: ClipRRect(
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//           child: SizedBox(
//             height: 60,
//             child: BottomNavigationBar(
//               onTap: onTapped,
//               type: BottomNavigationBarType.fixed,
//               currentIndex: widget.currentIndex,
//               backgroundColor: bottombarColor,
//               showSelectedLabels: false,
//               showUnselectedLabels: false,
//               selectedFontSize: 0,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: widget.currentIndex != 0
//                       ? Column(
//                           children: [
//                             SvgPicture.asset(
//                               home,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white60,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text('HOME', Colors.white60, 12, FontWeight.bold)
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             SvgPicture.asset(
//                               home,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text('HOME', Colors.white, 12, FontWeight.bold)
//                           ],
//                         ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: widget.currentIndex != 1
//                       ? Column(
//                           children: [
//                             SvgPicture.asset(
//                               matters,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white60,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text('MATTERS', Colors.white70, 12,
//                                 FontWeight.bold)
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             SvgPicture.asset(
//                               matters,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text('MATTERS', Colors.white, 12, FontWeight.bold)
//                           ],
//                         ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: widget.currentIndex != 2
//                       ? Column(
//                           children: [
//                             SvgPicture.asset(
//                               advocate,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white60,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text('ADVOCATE', Colors.white70, 12,
//                                 FontWeight.bold)
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             SvgPicture.asset(
//                               advocate,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text(
//                                 'ADVOCATE', Colors.white, 12, FontWeight.bold)
//                           ],
//                         ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: widget.currentIndex != 3
//                       ? Column(
//                           children: [
//                             SvgPicture.asset(
//                               services,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white60,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text('SERVICES', Colors.white70, 12,
//                                 FontWeight.bold)
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             SvgPicture.asset(
//                               services,
//                               height: 25,
//                               width: 25,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             text(
//                                 'SERVICES', Colors.white, 12, FontWeight.bold)
//                           ],
//                         ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: widget.currentIndex != 4
//                       ? Column(
//                           children: [
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             SvgPicture.asset(
//                               more,
//                               height: 5,
//                               width: 5,
//                               color: Colors.white60,
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             text('MORE', Colors.white70, 12, FontWeight.bold)
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             SvgPicture.asset(
//                               more,
//                               height: 5,
//                               width: 5,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             text('MORE', Colors.white, 12, FontWeight.bold)
//                           ],
//                         ),
//                   label: '',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
