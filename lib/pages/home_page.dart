import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_library/pages/detailed_books.dart';
import 'package:simple_library/pages/detailed_group.dart';
import 'package:simple_library/pages/login_page.dart';
import 'package:simple_library/pages/search_page.dart';
import 'package:simple_library/services/dashboard_services.dart';
import 'package:simple_library/shimmer/home_shimmer.dart';
import 'package:simple_library/templates/app_color.dart';
import 'package:simple_library/templates/app_size.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  String name = 'Anonim';
  var category = [];
  var recentBooks = [];
  var newBooks = [];
  var popularBooks = [];
  bool isLoading = false;

  var newBooks2 = [
    {
      'category': 'SD',
      'title': 'Pendidikan Agama Islam dan Budi Pekerti',
      'image': '',
    },
    {
      'category': 'SD',
      'title': 'Kewarganegaraan',
      'image': '',
    },
    {
      'category': 'SD',
      'title': 'Belajar Berhitung',
      'image': '',
    },
    {
      'category': 'SMP',
      'title': 'Penghitungan Aljabar',
      'image': '',
    },
    {
      'category': 'SMP',
      'title': 'Seni Budaya dan Penyebarannya',
      'image': '',
    },
    {
      'category': 'SMP',
      'title': 'Fisika Umum',
      'image': '',
    },
    {
      'category': 'SMA',
      'title': 'Kimia Terbarukan',
      'image': '',
    },
    {
      'category': 'SMA',
      'title': 'Sejarah Budaya Islam',
      'image': '',
    },
    {
      'category': 'SMA',
      'title': 'Hukum Alam Alias ya wes mboh',
      'image': '',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image(
                  image: AssetImage('assets/images/banner.jpg'),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 30, right: 24),
                  child: PopupMenuButton(
                    child: Icon(
                      Icons.more_vert,
                      color: AppColor.whiteColor,
                    ),
                    onSelected: (value) => {
                      showAlerDialog(context),
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(24, 90, 48, 0),
                  child: (isLoading)
                      ? nameShimmer()
                      : Text(
                          "Mornin' $name",
                          style: TextStyle(
                            color: AppColor.warmWhiteColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(24, 140, 24, 0),
                  decoration: BoxDecoration(
                    color: AppColor.warmWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: searchView(),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(AppSize.globalMargin),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  titleGroup('Books Category', () {}),
                  categoryList(),
                  SizedBox(height: 40),
                  titleGroup(
                      'New Books',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailedGroup(mode: 'new')))),
                  bookList(newBooks),
                  SizedBox(height: 40),
                  titleGroup(
                      'Most Popular Books',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailedGroup(mode: 'popular')))),
                  bookList(popularBooks),
                  SizedBox(height: 40),
                  titleGroup(
                      'Last Seen',
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailedGroup(mode: 'recent')))),
                  bookList(recentBooks),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  initFunction() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sp = await SharedPreferences.getInstance();
    var categoryRaw = await DashboardServices.getDashboard();

    setState(() {
      name = sp.getString('nama');
      category = categoryRaw['kategori'];
      recentBooks = categoryRaw['recent'];
      newBooks = categoryRaw['new'];
      popularBooks = categoryRaw['popular'];
      isLoading = false;
    });
  }

  showAlerDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel'),
    );

    Widget okButton = FlatButton(
      onPressed: () {
        signOut();
      },
      child: Text('Sure'),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Wanted To Log Out?'),
      content: Text('Are You sure You want to log out?'),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  signOut() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('isSession', '0');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  searchView() => TextField(
        // controller: searchController,
        // onChanged: (text) {
        //   searchFunction(text);
        // },
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'search title of the book',
          border: InputBorder.none,
        ),
      );

  searchFunction(String text) async {
    var resultRaw = await DashboardServices.getListBooks('', nama: text);
  }

  titleGroup(String text, Function() onTap) => (isLoading)
      ? titleShimmer()
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTap,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        );

  categoryList() => (isLoading)
      ? categoryShimmer()
      : Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (BuildContext context, int index) =>
                categoryContent(category[index]),
          ),
        );

  categoryContent(var data) => InkWell(
        onTap: () {
          log(data['id'].toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedGroup(
                mode: 'kategori',
                idCategory: data['id'].toString(),
              ),
            ),
          );
        },
        child: Container(
          height: 100,
          width: 140,
          margin: EdgeInsets.only(right: 16, top: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
          ),
          child: Center(
            child: Text(data['nama']),
          ),
        ),
      );

  bookList(var data) => (isLoading)
      ? bookListShimmer()
      : Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newBooks.length,
            itemBuilder: (BuildContext context, int index) =>
                bookContent(data[index]),
          ),
        );

  bookContent(var data) => Container(
        width: 160,
        margin: EdgeInsets.only(right: 16, top: 16),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedBooks(data: data))),
          child: Column(
            children: [
              labelCategoryBooks(data['nama_kategori'], data['url_sampul']),
              SizedBox(height: 12),
              Text(
                data['nama'],
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      );

  labelCategoryBooks(String label, String image) => Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: (image != null && image.toString().isNotEmpty)
                    ? NetworkImage(image)
                    : AssetImage('assets/images/book.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, top: 8),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(label),
          ),
        ],
      );

  nameShimmer() => Shimmer.fromColors(
        baseColor: AppColor.lightGrayColor,
        highlightColor: AppColor.whiteColor,
        enabled: true,
        child: Container(
          height: 30,
          width: 300,
          color: AppColor.lightGrayColor,
        ),
      );

  titleShimmer() => Shimmer.fromColors(
        baseColor: AppColor.lightGrayColor,
        highlightColor: AppColor.whiteColor,
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 30,
              width: 250,
              color: AppColor.lightGrayColor,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColor.lightGrayColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      );

  categoryShimmer() => Shimmer.fromColors(
        baseColor: AppColor.lightGrayColor,
        highlightColor: AppColor.whiteColor,
        enabled: true,
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 100,
                width: 140,
                margin: EdgeInsets.only(right: 16, top: 16),
                decoration: BoxDecoration(
                    color: AppColor.lightGrayColor,
                    borderRadius: BorderRadius.circular(10)),
              );
            },
          ),
        ),
      );

  bookListShimmer() => Shimmer.fromColors(
        baseColor: AppColor.lightGrayColor,
        highlightColor: AppColor.whiteColor,
        enabled: true,
        child: SizedBox(
          height: 350,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    height: 280,
                    width: 160,
                    margin: EdgeInsets.only(right: 16, top: 16),
                    decoration: BoxDecoration(
                      color: AppColor.lightGrayColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    margin: EdgeInsets.only(right: 16, top: 16),
                    color: AppColor.lightGrayColor,
                  ),
                ],
              );
            },
          ),
        ),
      );
}
