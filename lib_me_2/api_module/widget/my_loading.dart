import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget MyLoading(
  BuildContext context, {
  double padding = 0,
  int landscapeGrid = 3,
  int portraitGrid = 2,
  double gridRatio = 2 / 3,
}) {
  bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Skeletonizer(
    child: GridView.builder(
      padding: .all(padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: padding,
        crossAxisSpacing: padding,
        crossAxisCount: landscape ? landscapeGrid : portraitGrid,
        childAspectRatio: gridRatio,
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: .vertical,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  "asdsadsdas dsa das das da",
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  "sadsa das ds d as",
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
