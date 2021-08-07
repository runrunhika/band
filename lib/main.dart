import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'pages/M/mobileHomePage.dart';
import 'pages/W/webHomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rock Band',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      getPages: [GetPage(name: '/mainPage', page: () => MainPage())],
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final itemKey = GlobalKey();
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = ['assets/com.png', 'assets/co.png', 'assets/co2.jpg'];

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'adGhT_-JbZI',
    params: YoutubePlayerParams(
      startAt: Duration(seconds: 0),
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  YoutubePlayerController _controller2 = YoutubePlayerController(
    initialVideoId: 'sSHkXxADtaE',
    params: YoutubePlayerParams(
      startAt: Duration(seconds: 0),
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  Future scrollToItem() async {
    final context = itemKey.currentContext;

    await Scrollable.ensureVisible(context!,
        alignment: 0.5, duration: Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    _showDialog();
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              AlertDialog(
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                              child: Image.asset(
                            'assets/dialog1.png',
                            fit: BoxFit.cover,
                          )),
                          Container(
                              child: Image.network(
                                  'data:image/jpeg;base64,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')),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 40,
                      ))
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 15,
          title: Text(
            'THE PIPES',
            style: TextStyle(
              fontFamily: 'MonteCarlo',
              fontSize: 31,
            ),
          ),
          centerTitle: true,
        ),
        endDrawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            child: Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      'THE PIPES',
                      style: TextStyle(
                          fontFamily: 'MonteCarlo',
                          fontSize: 31,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    trailing: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 50,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'NEWS',
                      style: TextStyle(fontSize: 31, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'LIVE',
                      style: TextStyle(fontSize: 31, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'BIO',
                      style: TextStyle(fontSize: 31, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'DISC',
                      style: TextStyle(fontSize: 31, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'MOVIE',
                      style: TextStyle(fontSize: 31, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'GOODS',
                      style: TextStyle(fontSize: 31, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(Colors.white),
                  // trackBorderColor: MaterialStateProperty.all(Colors.green),
                  trackColor: MaterialStateProperty.all(Colors.red))),
          child: Scrollbar(
            isAlwaysShown: true,
            showTrackOnHover: true,
            hoverThickness: 20,
            thickness: 10,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    key: itemKey,
                    child: Image.asset(
                      'topImage.png',
                      fit: BoxFit.contain,
                      width: 600,
                      height: 600,
                    ),
                  ),
                  CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: urlImages.length,
                    options: CarouselOptions(
                        height: 100,
                        initialPage: 0,
                        autoPlay: true,
                        reverse: false,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        }),
                    itemBuilder: (ctx, index, realIndex) {
                      final urlImage = urlImages[index];
                      return buildImage(urlImage, index);
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.youtube),
                        color: Colors.white,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.twitter),
                          color: Colors.white),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.facebook,
                              color: Colors.white)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.instagram,
                              color: Colors.white)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.amazon,
                              color: Colors.white)),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.black,
                      child: Row(
                        children: [
                          Container(
                              height: 34,
                              width: 60,
                              child: VerticalDivider(
                                color: Colors.pink,
                                thickness: 7,
                              )),
                          Text(
                            'NEWS',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '2021/08/05',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        subtitle: Text(
                          'Hiroga「ユウリチャンネル」に出演！',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '2021/08/05',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        subtitle: Text(
                          'Hiroga「ユウリチャンネル」に出演！',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '2021/08/05',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        subtitle: Text(
                          'Hiroga「ユウリチャンネル」に出演！',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.black,
                      child: Row(
                        children: [
                          Container(
                              height: 34,
                              width: 60,
                              child: VerticalDivider(
                                color: Colors.pink,
                                thickness: 7,
                              )),
                          Text(
                            'LIVE',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '開催日: 2021/08/21',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        subtitle: Text(
                          '武道館',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '開催日: 2021/08/21',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        subtitle: Text(
                          '武道館',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '開催日: 2021/08/21',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        subtitle: Text(
                          '武道館',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.black,
                      child: Row(
                        children: [
                          Container(
                              height: 68,
                              width: 60,
                              child: VerticalDivider(
                                color: Colors.pink,
                                thickness: 7,
                              )),
                          Text(
                            'STORYTELLER\nINFO',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '2021/08/05',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        subtitle: Text(
                          'Update to BLOG',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '2021/08/05',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        subtitle: Text(
                          'Update to BLOG',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      color: Colors.grey.withOpacity(.2),
                      elevation: 25,
                      child: ListTile(
                        title: Text(
                          '2021/08/05',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        subtitle: Text(
                          'Update to BLOG',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.black,
                      child: Row(
                        children: [
                          Container(
                              height: 68,
                              width: 60,
                              child: VerticalDivider(
                                color: Colors.pink,
                                thickness: 7,
                              )),
                          Text(
                            'STORYTELLER\nMENU',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: YoutubePlayerControllerProvider(
                        controller: _controller,
                        child: YoutubePlayerIFrame(
                          aspectRatio: 16 / 9,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: YoutubePlayerControllerProvider(
                        controller: _controller2,
                        child: YoutubePlayerIFrame(
                          aspectRatio: 16 / 9,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: ElevatedButton(
                            onPressed: scrollToItem, child: Text('PAGE TOP')),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'THE PIPES',
                            style: TextStyle(
                                fontFamily: 'MonteCarlo',
                                fontSize: 51,
                                color: Colors.white),
                          ),
                          Text(
                            'THE PIPES',
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          ),
                          Text(
                            '掲載されているすべてのコンテンツ\n記事、画像，音声データ、映像データの無断転載を固く禁じます。',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.asset(
        urlImage,
      ),
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}
