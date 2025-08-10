import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../core/app_router/app_router.gr.dart';
import '../../../data/repo_impl/extension_repo_impl.dart';
import '../account/account_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final extensionRepo = ExtensionRepoImpl();

  @override
  void initState() {
    extensionRepo.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                showCupertinoSheet(
                  context: context,
                  useNestedNavigation: true,
                  pageBuilder: (context) => AccountScreen(),
                );
              },
              icon: Icon(CupertinoIcons.person_alt_circle),
            ),
            centerTitle: false,
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: const TabBar(
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    tabs: <Widget>[
                      Tab(text: "Kệ sách"),
                      Tab(text: "Lịch sử"),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // extensionRepo.home();
                  extensionRepo.test();
                },
                icon: Icon(CupertinoIcons.ellipsis_vertical),
              ),
            ],
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(child: Text("It's cloudy here")),
              Center(child: Text("It's rainy here")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              context.router.push(const HomeRoute());
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              context.router.push(const AccountRoute());
              break;
          }
        },
        // indicatorColor: Colors.amber,
        selectedIndex: 0,
        destinations: const <Widget>[
          NavigationDestination(
            // selectedIcon: Icon(CupertinoIcons.house_fill),
            icon: Icon(CupertinoIcons.house),
            label: 'Kệ sách',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.doc_text_search),
            label: 'Khám phá',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.chat_bubble_text),
            label: 'Cộng đồng',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.search),
            label: 'Tìm kiếm',
          ),
        ],
      ),
    );
  }
}
