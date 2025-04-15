/*
* 기능명 : Flutter - App introducing screen
* 파일명 : main.dart
* 작성자 : 서민정
* 설명 :
        상단바의 IconButton : 웹페이지 및 인스타그램 페이지로 이동
    - 화면이 바뀔 때에도 상단에 고정된 채로 계속 따라다니도록 설정

        _buildFirstPage() : 첫번째 페이지. 회사 정체성 소개 화면
    - 움직이는 gif 이미지를 넣어서 동적인 화면 구성
    - 하단의 네모버튼 클릭 시, 웹페이지의 '모임' 탭으로 이동

        _buildSecondPage() : 두번째 페이지. 회사의 핵심가치 소개 화면
    - 하단의 네모버튼 클릭 시, 웹페이지의 '회원가입' 탭으로 이동

        _buildThirdPage() : 세번째 페이지. 산 홍보 화면
    - 사진 누르면 인스타그램으로 이동 -> 해당 게시물 설명을 자세히 볼 수 있습니다

* 작성일 : 2025-03-19 ~ 04-15
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '하이등산 M',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'NotoSansKR', // 기본 폰트 설정 (필요에 따라)
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<dynamic> _instagramFeeds = [];

  @override
  void initState() {
    super.initState();
    _fetchInstagramFeeds();
  }

  Future<void> _fetchInstagramFeeds() async {
    // 실제 인스타그램 API 엔드포인트로 변경
    // final response = await http.get(Uri.parse('YOUR_INSTAGRAM_API_ENDPOINT'));
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _instagramFeeds = json.decode(response.body);
    //   });
    // } else {
    //   print('Failed to load Instagram feeds');
    // }
    // 임시 데이터 (API 연동 전)
    setState(() {
      _instagramFeeds = List.generate(9, (index) => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // AppBar 투명하게 처리하고 body 영역 확장
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.withOpacity(0.8), // 반투명한 상단바
        elevation: 0, // 그림자 제거
        title: const Text(
          '하이펜타 M',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.network(
              'https://img.icons8.com/ios-filled/50/ffffff/internet-explorer.png',
              width: 28,
              height: 28,
            ),
            onPressed: () async {
              final Uri url = Uri.parse(
                'http://ec2-3-39-235-2.ap-northeast-2.compute.amazonaws.com:8080',
              );
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          IconButton(
            icon: Image.network(
              'https://img.icons8.com/ios-glyphs/50/ffffff/instagram-circle.png',
              width: 28,
              height: 28,
            ),
            onPressed: () async {
              final Uri url = Uri.parse(
                'https://www.instagram.com/high_penta.m/',
              );
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              _buildFirstPage(context),
              _buildSecondPage(context),
              _buildThirdPage(context),
            ],
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPageIndicator(0),
                _buildPageIndicator(1),
                _buildPageIndicator(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int pageIndex) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: _currentPage == pageIndex ? 16 : 10,
      height: _currentPage == pageIndex ? 16 : 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == pageIndex ? Colors.green[400] : Colors.grey[300],
      ),
    );
  }

  Widget _buildFirstPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green[50]!, Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100), // AppBar 공간 확보
            Text(
              '하이등산 소개',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.grey[800],
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: '우리는 푸른 자연을 사랑하고, 함께 발맞춰 나아가는 즐거움을 추구하는 사람들의 ',
                  ),
                  TextSpan(
                    text: '등산 커뮤니티',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green[600],
                    ),
                  ),
                  const TextSpan(text: ' 입니다.\n\n'),
                  const TextSpan(
                    text: '일상의 활력을 되찾고, 아름다운 산의 풍경 속에서 소중한 추억을 만들어보세요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZDAwYXMyZWllNThvd2lkajNrdGtnZ3AyZ3VyZTVlZnp1eGQwZHdwYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/pTWhYGfCXBvEyBv1nj/giphy.gif',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.hiking, color: Colors.green[400], size: 26),
                      const SizedBox(width: 12),
                      Text(
                        '주요 활동',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    icon: Icons.directions_walk,
                    text: '정기적인 테마 등산 모임 운영',
                  ),
                  const SizedBox(height: 12),
                  _buildActivityItem(
                    icon: Icons.forum,
                    text: '등산 경험 및 정보 공유 커뮤니티 운영',
                  ),
                  const SizedBox(height: 12),
                  _buildActivityItem(
                    icon: Icons.lightbulb_outline,
                    text: '안전한 등산을 위한 다양한 정보 제공',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(
                  'http://ec2-3-39-235-2.ap-northeast-2.compute.amazonaws.com:8080/clubs',
                );
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '지금 바로 모임에 참여하고\n함께 등산을 시작해보세요!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.green[600], size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.lightGreen[50]!, Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            Text(
              '핵심 가치',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.grey[800],
                ),
                children: <TextSpan>[
                  const TextSpan(text: '하이등산은 '),
                  TextSpan(
                    text: '자연과의 조화',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green[600],
                    ),
                  ),
                  const TextSpan(text: ', '),
                  TextSpan(
                    text: '안전 최우선',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green[600],
                    ),
                  ),
                  const TextSpan(text: ', 그리고 '),
                  TextSpan(
                    text: '함께하는 즐거움',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green[600],
                    ),
                  ),
                  const TextSpan(text: '을 핵심 가치로 생각합니다.'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildCoreValueItem(
              number: '1',
              title: '지속 가능한 등산 문화',
              description: '자연을 존중하고 보호하며, 환경에 부담을 주지 않는 등산 문화를 선도합니다.',
              icon: Icons.eco_outlined,
            ),
            const SizedBox(height: 20),
            _buildCoreValueItem(
              number: '2',
              title: '안전하고 즐거운 경험',
              description: '체계적인 안전 교육과 준비를 통해 모든 회원이 안심하고 등산을 즐길 수 있도록 지원합니다.',
              icon: Icons.security_outlined,
            ),
            const SizedBox(height: 20),
            _buildCoreValueItem(
              number: '3',
              title: '커뮤니티와 소통',
              description:
                  '회원 간의 활발한 교류와 소통을 통해 끈끈한 유대감을 형성하고, 함께 성장하는 커뮤니티를 지향합니다.',
              icon: Icons.people_outline,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(
                  'http://ec2-3-39-235-2.ap-northeast-2.compute.amazonaws.com:8080/join',
                );
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.green[400]!, Colors.green[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '하이등산과 함께\n새로운 도전을 시작하세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoreValueItem({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.green[100],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.green[600], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThirdPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green[50]!, Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            Text(
              '최신 등산 소식',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 1),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                final imagePaths = [
                  'assets/images/image9.jpg',
                  'assets/images/image8.jpg',
                  'assets/images/image7.jpg',
                  'assets/images/image6.jpg',
                  'assets/images/image5.jpg',
                  'assets/images/image4.jpg',
                  'assets/images/image3.jpg',
                  'assets/images/image2.jpg',
                  'assets/images/image1.jpg',
                ];
                final feedUrls = [
                  'https://www.instagram.com/p/DHmx-00vclu/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmx4lFPBjT/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxyGAvAUP/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxrSLPAbr/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxmQoPhvP/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxgqtvO1U/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxZv8PIC_/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxSltPTa1/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                  'https://www.instagram.com/p/DHmxAxgPiP_/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==',
                ];
                return InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse(feedUrls[index]);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            const Center(
              child: Text(
                '\n(상단 우측 아이콘을 통해 인스타그램 페이지를\n확인하실 수 있습니다.)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
