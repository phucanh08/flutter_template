import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/core/app_router/app_router.gr.dart';
import 'package:flutter_template/ui/screens/sources/sources_screen.dart';

@RoutePage()
class ExtensionsScreen extends StatelessWidget {
  const ExtensionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const TabBar(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: "Bản cập nhật"),
              Tab(text: "Thư viện"),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
            IconButton(
              onPressed: () {
                // showModalBottomSheet(
                //   useSafeArea: true,
                //   context: context,
                //   isScrollControlled: true,
                //   showDragHandle: false,
                //   isDismissible: true,
                //   enableDrag: true,
                //   sheetAnimationStyle: AnimationStyle(curve: Curves.linear),
                //   builder: (BuildContext context) => DraggableScrollableSheet(
                //     snapSizes: [0.5, 1.0],
                //     initialChildSize: 0.5,
                //     minChildSize: 0.1,
                //     maxChildSize: 1.0,
                //     expand: false,
                //     snap: true,
                //     shouldCloseOnMinExtent: true,
                //     builder:
                //         (
                //           BuildContext context,
                //           ScrollController scrollController,
                //         ) {
                //           return Container(
                //             color: Colors.white,
                //             child: ListView.builder(
                //               controller: scrollController,
                //               itemCount: 25,
                //               itemBuilder: (BuildContext context, int index) {
                //                 return CupertinoListTile(
                //                   title: Text('Item $index'),
                //                 );
                //               },
                //             ),
                //           );
                //         },
                //   ),
                // );
                showCupertinoSheet<void>(
                  context: context,
                  useNestedNavigation: true,
                  enableDrag: true,
                  pageBuilder: (BuildContext context) => DraggableScrollableSheet(
                    snapSizes: [0.5, 1.0],
                    initialChildSize: 0.5,
                    minChildSize: 0.1,
                    maxChildSize: 1.0,
                    expand: false,
                    snap: true,
                    shouldCloseOnMinExtent: false,
                    builder: (BuildContext context, ScrollController scrollController) {
                      return Container(
                        color: Colors.white,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 25,
                          itemBuilder: (BuildContext context, int index) {
                            return CupertinoListTile(
                              title: Text('Item $index'),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              icon: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ],
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: Text("Bản cập nhật")),
            Center(child: Text("Thư viện")),
          ],
        ),
      ),
    );
  }
}
