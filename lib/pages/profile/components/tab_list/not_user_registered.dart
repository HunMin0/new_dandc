import 'package:flutter/material.dart';

class NotUserRegistered extends StatelessWidget {
  final bool isTabType;

  const NotUserRegistered({
    required this.isTabType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyleTitle = TextStyle(
      color: Color(0xFF75A8E4),
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
    );
    const textStyleMainTitle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    );
    const textStyleSubTitle = TextStyle(
      fontSize: 13.0,
      color: Color(0xFF666666),
    );

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: const BoxDecoration(
          color: Color(0xFFf5f6f8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            left: 14.0,
            right: 14.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: isTabType
                    ? Column(
                        children: [
                          const Text(
                            '연결의 첫 시작',
                            style: textStyleTitle,
                          ),
                          const Text(
                            '내 업체 등록하기',
                            style: textStyleMainTitle,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          const Text(
                            '업체를 등록하고 다른 사장님들과\n파트너를 맺어보세요!',
                            textAlign: TextAlign.center,
                            style: textStyleSubTitle,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Image.asset(
                            'assets/images/icons/store_img.png',
                            height: 100.0,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _TabBarButton(
                                    btnTitle: '업체 등록하기', onPressed: () {}),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const Text(
                            '소통의 첫 시작',
                            style: textStyleTitle,
                          ),
                          const Text(
                            '등록된 글이 없습니다',
                            style: textStyleMainTitle,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          const Text(
                            '파트너를 맺고 다른 사장님들과\n이야기를 나눠보세요!',
                            textAlign: TextAlign.center,
                            style: textStyleSubTitle,
                          ),
                          Image.asset(
                            'assets/images/icons/partner_post.png',
                            height: 100.0,
                          ),
                        ],
                      )),
          ),
        ),
      ),
    );
  }
}

class _TabBarButton extends StatelessWidget {
  final String btnTitle;
  final VoidCallback onPressed;

  const _TabBarButton({
    required this.btnTitle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        backgroundColor: Color(0xFF75A8E4),
        foregroundColor: Color(0xFF75A8E4),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
