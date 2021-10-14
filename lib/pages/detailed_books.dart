import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_library/pages/read_book.dart';
import 'package:simple_library/templates/app_color.dart';
import 'package:simple_library/templates/custom_button.dart';

class DetailedBooks extends StatefulWidget {
  var data;
  DetailedBooks({@required this.data, Key key}) : super(key: key);

  @override
  _DetailedBooksState createState() => _DetailedBooksState();
}

class _DetailedBooksState extends State<DetailedBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Detail Buku'),
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          Container(
            height: 250,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (widget.data['url_sampul'] != null)
                    ? NetworkImage(widget.data['url_sampul'])
                    : AssetImage('assets/images/book.png'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  widget.data['nama'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                labelCategory(widget.data['nama_kategori']),
                SizedBox(height: 12),
                Text(
                  widget.data['deskripsi'],
                  // 'A wonderful fairy tale of the sun and the earth while they were searching for their identity. Their experience somehow will give you another meaning of life.',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.grayColor,
                  ),
                ),
                SizedBox(height: 32),
                CustomButton(
                  buttonText: 'Baca',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadBook(
                        url: widget.data['url_file'],
                        title: widget.data['nama'],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  labelCategory(String label) => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(label),
      );
}
