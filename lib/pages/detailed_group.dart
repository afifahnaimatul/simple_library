import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_library/services/dashboard_services.dart';
import 'package:simple_library/templates/app_color.dart';
import 'package:simple_library/templates/app_size.dart';

class DetailedGroup extends StatefulWidget {
  var mode;
  var idCategory;

  DetailedGroup({this.mode = '', this.idCategory = '', Key key})
      : super(key: key);

  @override
  _DetailedGroupState createState() => _DetailedGroupState();
}

class _DetailedGroupState extends State<DetailedGroup> {
  final searchController = TextEditingController();
  var result = [];
  var newBooks = [
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
    initialFunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Terbaru'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(AppSize.globalMargin,
              AppSize.globalMargin * 2, AppSize.globalMargin, 0),
          child: Column(
            children: [
              searchView(),
              SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (context, position) {
                  return bookLists(result[position]);
                },
                separatorBuilder: (context, position) {
                  return SizedBox(height: 8);
                },
              ),
              // bookLists(),
              // SizedBox(height: 8),
              // bookLists(),
              // SizedBox(height: 8),
              // bookLists(),
              // SizedBox(height: 8),
              // bookLists(),
            ],
          ),
        ),
      ),
    );
  }

  searchView() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.grayColor,
                  width: 0.2,
                ),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (text) {
                  searchFunction(text);
                },
                // onChanged: (text) {
                //   print('hasil ketik: $text');
                // },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'search title of the book',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.search,
                  color: AppColor.warmWhiteColor,
                ),
              ),
            ),
          )
        ],
      );

  searchFunction(String text) async {
    var resultRaw = await DashboardServices.getListBooks(widget.mode,
        id: widget.idCategory, nama: text);
    setState(() {
      result = resultRaw;
    });
  }

  initialFunction() async {
    var resultRaw = await DashboardServices.getListBooks(widget.mode,
        id: widget.idCategory);
    setState(() {
      result = resultRaw;
    });
  }

  bookLists(var data) => Container(
        height: 220,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Container(
              height: 200,
              width: 135,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (data['url_sampul'] != null)
                        ? NetworkImage(data['url_sampul'])
                        : AssetImage('assets/images/book.png'),
                  )),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['nama'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  labelCategory(data['nama_kategori']),
                  SizedBox(height: 8),
                  Container(
                    width: 250,
                    child: Text(
                      data['deskripsi'],
                      // 'A wonderful fairy tale of the sun and the earth while they were searching for their identity. Their experience somehow will give you another meaning of life.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        color: AppColor.grayColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  labelCategory(String label) => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(label),
      );
}
