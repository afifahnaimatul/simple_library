import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF000000),
        highlightColor: Color(0xFFB3B3B3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 90),
            Container(
              height: 30,
              width: 350,
              color: Colors.amber,
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 60),
            Container(
              height: 30,
              width: 250,
              color: Colors.amber,
            ),
            SizedBox(height: 20),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
