import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../core/app_router/app_router.gr.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(centerTitle: false, title: const Text('Cá nhân')),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 32,
                      child: Icon(CupertinoIcons.person_fill),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Khách', style: theme.textTheme.titleLarge),
                        SizedBox(height: 4),
                        Text('Chưa đăng nhập', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text("Đăng nhập"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text("Đăng ký"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Ứng dụng'),
            tileColor: theme.colorScheme.surfaceContainer,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.archivebox),
            title: Text('Lưu trữ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.chart_bar_square),
            title: Text('Thống kê'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.rectangle_3_offgrid),
            title: Text('Phần mở rộng'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.arrow_2_circlepath),
            title: Text('Đồng bộ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.settings),
            title: Text('Cài đặt'),
            onTap: () => router.push(SettingsRoute()),
          ),
          ListTile(
            title: const Text('Kết nối'),
            tileColor: theme.colorScheme.surfaceContainer,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.share),
            title: Text('Mời bạn bè sử dụng'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.facebook),
            title: Text('Theo dõi Fanpage'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.discord),
            title: Text('Tham gia discord'),
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Phiên bản: 1.0.0"),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.arrow_clockwise),
          ),
        ],
      ),
    );
  }
}
