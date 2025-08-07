import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text('Cài đặt')),
      body: ListView(
        children: [
          Text('CHUNG'),
          Divider(),
          ListTile(
            title: Text('Màu sắc'),
            subtitle: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    CircleAvatar(backgroundColor: Colors.primaries[index]),
                itemCount: Colors.primaries.length,
                itemExtent: 54,
              ),
            ),
          ),
          ListTile(
            title: Text('Chủ đề tối'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Theo hệ thống'),
                Icon(CupertinoIcons.chevron_right),
              ],
            ),
          ),
          ListTile(
            title: Text('Nền đen ở chế độ tối'),
            trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
          ),
          ListTile(
            title: Text('Nổi bật thanh tiêu đề'),
            trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
          ),
          ListTile(
            title: Text('Giao diện EInk'),
            trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
          ),
          ListTile(
            title: Text('Ngôn ngữ'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Theo hệ thống'),
                Icon(CupertinoIcons.chevron_right),
              ],
            ),
          ),
          ListTile(
            title: Text('Phông chữ'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Nunito'), Icon(CupertinoIcons.chevron_right)],
            ),
          ),
          ListTile(
            title: Text('Bộ nhớ lưu trữ'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Bộ nhớ trong (chia sẻ)'),
                Icon(CupertinoIcons.chevron_right),
              ],
            ),
          ),
          ListTile(
            title: Text('Tự động mở truyện vừa đọc'),
            trailing: CupertinoSwitch(value: true, onChanged: (value) {}),
          ),
          ListTile(
            title: Text('Cập nhật chương mới'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Không kiểm tra'),
                Icon(CupertinoIcons.chevron_right),
              ],
            ),
          ),
          ListTile(
            title: Text('Lịch sao lưu'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Thủ công'), Icon(CupertinoIcons.chevron_right)],
            ),
          ),
          ListTile(
            title: Text('Làm mờ ảnh bìa truyện nsfw'),
            trailing: CupertinoSwitch(value: true, onChanged: (value) {}),
          ),
          ListTile(
            title: Text('Vuốt để quay lại'),
            trailing: CupertinoSwitch(value: true, onChanged: (value) {}),
          ),
          Text('KẾT NỐI'),
          Divider(),
          ListTile(
            title: Text('Thời gian nghỉ'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('100ms'), Icon(CupertinoIcons.chevron_right)],
            ),
          ),
          ListTile(
            title: Text('Số luồng tải xuống'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('2 luồng'), Icon(CupertinoIcons.chevron_right)],
            ),
          ),
          ListTile(
            title: Text('Tải lại khi bị lỗi'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('3'), Icon(CupertinoIcons.chevron_right)],
            ),
          ),
          ListTile(
            title: Text('DNS over HTTPS'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Không'), Icon(CupertinoIcons.chevron_right)],
            ),
          ),
          ListTile(
            title: Text('Sử dụng Cronet (Hỗ trợ HTTP3)'),
            trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
          ),
          Text('DỊCH'),
          Divider(),
          ListTile(
            title: Text('Tự động dịch nguồn trung'),
            trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
          ),
        ],
      ),
    );
  }
}
