import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_library/pages/detailed_books.dart';
import 'package:simple_library/services/dashboard_services.dart';
import 'package:simple_library/templates/app_color.dart';
import 'package:simple_library/templates/app_size.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  var result = [];

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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.all(AppSize.globalMargin),
              child: searchBar(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSize.globalMargin),
                child: ListView.separated(
                  itemCount: result.length,
                  itemBuilder: (context, position) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailedBooks(data: result[position]),
                          ),
                        );
                      },
                      child: Container(
                        child: Text(result[position]['nama']),
                      ),
                    );
                  },
                  separatorBuilder: (context, position) {
                    return Divider(
                      height: 24,
                      thickness: 0.2,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  initialFunction() async {
    var resultRaw = await DashboardServices.getListBooks('');
    setState(() {
      result = resultRaw;
    });
  }

  searchBar() => Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_outlined,
            ),
          ),
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: AppSize.globalMargin),
              margin: EdgeInsets.only(left: AppSize.globalMargin),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.lightGrayColor,
              ),
              child: TextField(
                controller: searchController,
                onChanged: (text) {
                  searchFunction(text);
                },
                decoration: InputDecoration(
                  hintText: 'search a book or category',
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      );

  searchFunction(String text) async {
    var resultRaw = await DashboardServices.getListBooks('', nama: text);
    setState(() {
      result = resultRaw;
    });
  }
}
