import 'package:DealConnect/components/custom/highlight_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchHeader extends StatelessWidget {
  Function onTab;
  final bool isExpanded;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  SearchHeader({Key? key, this.isExpanded = true, required this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _searchView(context),
        ],
      ),
    );
  }

  _searchView(BuildContext context) {
    print('isExpanded: ' + isExpanded.toString());
    return isExpanded ? Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              child: CupertinoTextField(
                keyboardType: TextInputType.text,
                placeholder: '지역 또는 단지명을 입력하세요.',
                placeholderStyle: const TextStyle(
                    color: Color(0xffC4C6CC),
                    fontSize: 15.0,
                    fontFamily: 'Brutal',
                    fontWeight: FontWeight.bold),
                prefix: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5.0, 5.0, 0.0, 5.0),
                  child: Icon(
                    Icons.search,
                    size: 25,
                    color: HexColor('#293bf0'),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    border: Border.all(
                        color: HexColor('#293bf0'), width: 1.5)),
                onSubmitted: (value) {
                  print('submit : $value');

                  Navigator.pushNamed(
                    context,
                    '/search/list',
                    arguments: {
                      'keyword': value,
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: TextButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  'assets/images/list-icon.png',
                ),
              ),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    ) : Column(
      children: [
        // Container(
        //   margin: EdgeInsets.only(bottom: 10),
        //   child: Row(
        //     children: [
        //       TextButton(
        //         onPressed: () {
        //           print('공간');
        //         },
        //         child: Text(
        //           '공간',
        //           textAlign: TextAlign.start,
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: HexColor('#222222'),
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         style: TextButton.styleFrom(
        //           minimumSize: Size.zero,
        //           padding: EdgeInsets.zero,
        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //         ),
        //       ),
        //       Container(
        //         padding: const EdgeInsets.only(top: 3, left: 8, right: 8),
        //         child: Text(
        //           'I',
        //           textAlign: TextAlign.start,
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: HexColor('#a5a5a5'),
        //           ),
        //         ),
        //       ),
        //       TextButton(
        //         onPressed: () {
        //           print('인테리어');
        //           onTab(2);
        //         },
        //         child: Text(
        //           '인테리어',
        //           textAlign: TextAlign.start,
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: HexColor('#b9b8b8'),
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         style: TextButton.styleFrom(
        //           minimumSize: Size.zero,
        //           padding: EdgeInsets.zero,
        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
            keyboardType: TextInputType.text,
            placeholder: '지역 또는 단지명을 입력하세요.',
            placeholderStyle: const TextStyle(
                color: Color(0xffC4C6CC),
                fontSize: 15.0,
                fontFamily: 'Brutal',
                fontWeight: FontWeight.bold),
            prefix: Padding(
              padding: const EdgeInsets.fromLTRB(
                  5.0, 5.0, 0.0, 5.0),
              child: Icon(
                Icons.search,
                size: 25,
                color: HexColor('#293bf0'),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
                border: Border.all(
                    color: HexColor('#293bf0'), width: 1.5)),
            onSubmitted: (value) {
              print('submit : $value');

              Navigator.pushNamed(
                context,
                '/search/list',
                arguments: {
                  'keyword': value,
                },
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {
                    print('BU안전거래');
                    Navigator.pushNamed(context, '/faq/category/list', arguments: {
                      'category_title': '안전거래',
                    });
                  },
                  child: Text(
                    'BU안전거래',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 13,
                      color: HexColor('#3e3e3e'),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {
                    print('BU보증');
                    Navigator.pushNamed(context, '/faq/category/list', arguments: {
                      'category_title': '보증',
                    });
                  },
                  child: Text(
                    'BU보증',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 13,
                      color: HexColor('#3e3e3e'),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {
                    print('BU서비스');
                    Navigator.pushNamed(context, '/faq/category/list', arguments: {
                      'category_title': '서비스',
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          'BU서비스',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 13,
                            color: HexColor('#3e3e3e'),
                          ),
                        ),
                      ),
                      HighlightText(
                        content: 'N',
                        paddingHorizontal: 4,
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('최근검색');
                        Navigator.pushNamed(context, '/search/list');
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              '최근검색 >',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor('#878787'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 0),
            width: MediaQuery.of(context).size.width,
            height: 1,
            decoration: BoxDecoration(color: HexColor('#ededed'))
        ),
      ],
    );
  }
}