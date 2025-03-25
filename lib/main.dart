import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '등산 앱',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
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
    final response = await http.get(Uri.parse('YOUR_INSTAGRAM_API_ENDPOINT'));
    if (response.statusCode == 200) {
      setState(() {
        _instagramFeeds = json.decode(response.body);
      });
    } else {
      print('Failed to load Instagram feeds');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildFirstPage(),
              _buildSecondPage(),
              _buildThirdPage(),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: SafeArea(
                child: Container(
                  height: 60,
                  color: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        '하이펜타 M',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Image.network(
                              'https://img.icons8.com/ios-filled/50/ffffff/internet-explorer.png',
                              width: 30,
                              height: 30,
                            ),
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                'https://www.naver.com',
                              );
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                          ),
                          IconButton(
                            icon: Image.network(
                              'https://img.icons8.com/ios-glyphs/50/ffffff/instagram-circle.png',
                              width: 30,
                              height: 30,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == pageIndex ? 12 : 8,
      height: _currentPage == pageIndex ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == pageIndex ? Colors.green : Colors.grey,
      ),
    );
  }

  Widget _buildFirstPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 80),
          const Text(
            '하이펜타 M 소개',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green, // 회사 소개 강조
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '우리는 산을 사랑하는 사람들이 모여 만든 등산 커뮤니티입니다.',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZDAwYXMyZWllNThvd2lkajNrdGtnZ3AyZ3VyZTVlZnp1eGQwZHdwYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/pTWhYGfCXBvEyBv1nj/giphy.gif',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '주요 활동',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green, // 주요 활동 강조
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '1. 정기적인 등산 모임 및 행사 개최',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const Text(
            '2. 등산 정보 공유 및 커뮤니티 활동',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const Text(
            '3. 환경 보호 캠페인 및 봉사활동',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 32),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.green.shade100,
            ),
            child: const Center(
              child: Text(
                '지금 바로 함께 산으로 떠나보세요!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 80),
          const Text(
            '핵심 가치',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green, // 핵심 가치 강조
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '우리는 자연과 사람을 연결하는 가치를 추구합니다.',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 24),
          const Text(
            '1. 지속 가능한 미래: 환경 보호를 최우선으로 생각하며, 지속 가능한 등산 문화를 만들어갑니다.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const Text(
            '2. 안전과 신뢰: 안전한 등산 환경을 제공하고, 고객과의 신뢰를 최우선으로 생각합니다.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const Text(
            '3. 혁신과 도전: 끊임없는 혁신을 통해 새로운 등산 경험을 제공하고, 도전을 두려워하지 않습니다.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 32),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.green.shade200, Colors.green.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                '자연과 함께, 미래를 향해',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 80),
          const Text(
            '인스타그램',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green, // 인스타그램 문구 강조
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
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
              return GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(feedUrls[index]);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imagePaths[index], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
