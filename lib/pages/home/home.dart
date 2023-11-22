import 'package:DealConnect/utils/shared_pref_utils.dart';
import 'package:DealConnect/components/custom/highlight_text.dart';
import 'package:DealConnect/components/custom/search_header.dart';
import 'package:DealConnect/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/foundation.dart' as foundation;

/* BU 파일 */

class Home extends StatefulWidget {
  Function onTab;

  Home({Key? key, required this.onTab}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var navHeight = 0.0;

  User? myUser;

  @override
  void initState() {
    _initMyUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, ext) => [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: false,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset('assets/images/logo-blue.png'),
                      ),
                      IconButton(
                        icon: Image.asset('assets/images/list-icon.png', width: 20, height: 20, fit: BoxFit.contain),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 160,
            collapsedHeight: 100,
            automaticallyImplyLeading: false,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                navHeight = constraints.biggest.height;
                print(navHeight);
                return SearchHeader(isExpanded: navHeight <= 140.0, onTab: widget.onTab);
              },
            ),
            actions: [
              Icon(
                Icons.search,
                size: 25,
                color: Colors.transparent,
              ),
            ],
          ),
        ],
        body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          '노는공간',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        HighlightText(
                          topMargin: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(width: 1, color: HexColor('#222222'))
                      ),
                      onPressed: () {
                        widget.onTab(1);
                      },
                      child: Text(
                        '더 많은 방 보러가기',
                        style: TextStyle(
                            color: HexColor('#222222'),
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                      decoration: BoxDecoration(color: HexColor('#ededed'))
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }


  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) {
      setState(() {
        myUser = value;
      });
    });
  }



  @override
  void dispose() {
    // marketingVideoControllers.forEach((controller) {
    //   controller.dispose();
    // });
    super.dispose();
  }
}