import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/pages/home/history_page.dart';
import 'package:shop_firebase/pages/home/home_page.dart';
import 'package:shop_firebase/pages/home/me_page.dart';
import 'package:shop_firebase/utils/app_color.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _pageIndex = 0;
  List _page = [
    HomePage(),
    HistoryPage(),
    MePage()
  ];

  void onTapNav(int index){
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _page[_pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.smallTextColor,
          showSelectedLabels: true,
          onTap: onTapNav ,
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          ],
        )
    );
  }
}
