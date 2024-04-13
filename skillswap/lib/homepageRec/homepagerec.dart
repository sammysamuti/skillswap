import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/homepageCandidate/homescreen.dart';
import 'package:skillswap/homepageCandidate/message.dart';
import 'package:skillswap/homepageCandidate/personalproject.dart';
import 'package:skillswap/homepageCandidate/profile.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
import 'package:skillswap/homepageCandidate/sidebar.dart';
import 'package:skillswap/homepageRec/HomeRec.dart';
import 'package:skillswap/homepageRec/message.dart';
import 'package:skillswap/homepageRec/profile.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/emojione.dart';
import '../recruiterPages/createJob.dart';
import '../recruiterPages/messages.dart';

class HomepageREC extends StatefulWidget {
  final String userid;
  HomepageREC(this.userid, {Key? key}) : super(key: key);

  @override
  State<HomepageREC> createState() => _HomepageRECState();
}

class _HomepageRECState extends State<HomepageREC> {
  late PageController _pageController;

  int _currentPageIndex = 0;
  final UserController usercontroller = Get.find();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          children: [
            HomeRecruiter(),
            // MyJobs(), jobs that userid posted
            MessagePage(currentUserUid: widget.userid),
            ProfileRec(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color.fromARGB(255, 237, 241, 245),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0, // Adjust the margin as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.house, size: 30),
              onPressed: () {
                _onItemTapped(0);
              },
              color: _currentPageIndex == 0 ? Color(0XFF2E307A) : Colors.grey,
            ),
            IconButton(
              icon: Icon(CupertinoIcons.folder, size: 30),
              onPressed: () {
                _onItemTapped(1);
              },
              color: _currentPageIndex == 1 ? Color(0XFF2E307A) : Colors.grey,
            ),
            IconButton(
              icon: Icon(CupertinoIcons.chat_bubble_2, size: 30),
              onPressed: () {
                _onItemTapped(2);
              },
              color: _currentPageIndex == 2 ? Color(0XFF2E307A) : Colors.grey,
            ),
            IconButton(
              icon: Icon(CupertinoIcons.person, size: 30),
              onPressed: () {
                _onItemTapped(3);
              },
              color: _currentPageIndex == 3 ? Color(0XFF2E307A) : Colors.grey,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostJobForm(),
            ),
          );
        },
        child: Icon(Icons.add, color: Color(0XFF2E307A), size: 30),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
