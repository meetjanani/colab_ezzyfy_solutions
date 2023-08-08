import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/home_dashboard/home_dashboard_page.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavigationPage extends StatefulWidget {
  BottomNavigationPage({Key? key, required this.currentIndex})
      : super(key: key);
  int currentIndex;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    List<Widget> _buildScreens = [
      HomeDashboardPage(),
      SizedBox(),
      SizedBox(),
      SizedBox(),
      SizedBox()
    ];

    void onTapped(int index) {
      setState(() {
        widget.currentIndex = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildScreens[widget.currentIndex],
        bottomNavigationBar: StylishBottomBar(
          option: BubbleBarOptions(

            // barStyle: BubbleBarStyle.vertical,
            barStyle: BubbleBarStyle.horizotnal,
            bubbleFillStyle: BubbleFillStyle.fill,
            // bubbleFillStyle: BubbleFillStyle.outlined,
            opacity: 0.3,
          ),
          items: [
            BottomBarItem(
              icon:  SvgPicture.asset(
                home
              ),
              selectedIcon:  SvgPicture.asset(home,color: Colors.blue,),
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey.shade400,
              backgroundColor: Colors.blue.shade200,
              //badgeRadius: BorderRadius.circular(50),
              title:  Text('Home',style: TextStyle(color: Colors.blue,fontSize: 15),),
              //badge:  Text('9+'),
              // showBadge: true,
            ),
            BottomBarItem(
              icon:  SvgPicture.asset(
                Document
              ),
              selectedIcon:  SvgPicture.asset(Document,color: Colors.blue,),
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey.shade400,
              backgroundColor: Colors.blue.shade200,
              //badgeRadius: BorderRadius.circular(50),
              title: const Text('Documents',style: TextStyle(color: Colors.blue),),
              //badge:  Text('9+'),
              // showBadge: true,
            ),
            BottomBarItem(
              icon:  SvgPicture.asset(
                bottomimage,color: Colors.white,
              ),
              selectedIcon:  SvgPicture.asset(bottomimage,color: Colors.white,),
              //selectedColor: Colors.blue,
              // unSelectedColor: Colors.grey.shade400,
              backgroundColor: Colors.white,
              //badgeRadius: BorderRadius.circular(50),
              title: const Text('Home',style: TextStyle(color: Colors.white),),
              //badge:  Text('9+'),
              // showBadge: true,
            ),
            BottomBarItem(
              icon:  SvgPicture.asset(
                bottomimage
              ),
              selectedIcon:  SvgPicture.asset(bottomimage,color: Colors.blue,),
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey.shade400,
              backgroundColor: Colors.blue.shade200,
              //badgeRadius: BorderRadius.circular(50),
              title: const Text('Images',style: TextStyle(color: Colors.blue),),
              //badge:  Text('9+'),
              // showBadge: true,
            ),
            BottomBarItem(
              icon:  SvgPicture.asset(
                Chat
              ),
              selectedIcon: SvgPicture.asset(Chat,color: Colors.blue,),
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey.shade400,
              backgroundColor: Colors.blue.shade200,
              //badgeRadius: BorderRadius.circular(50),
              title: const Text('Chat',style: TextStyle(color: Colors.blue),),
              //badge:  Text('9+'),
              // showBadge: true,
            ),
          ],
          currentIndex: widget.currentIndex,
          onTap: (index) {
            if(index == 2){
              return;
            }
            onTapped(index);
          },
          hasNotch: true,
          backgroundColor: Colors.white,
          //fabLocation: StylishBarFabLocation.,

        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.white,
          // elevation: 8,
          child: Icon(
            Icons.camera_alt,
            color: Colors.blue,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}
