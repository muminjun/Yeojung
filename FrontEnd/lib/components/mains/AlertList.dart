import 'package:flutter/material.dart';
import 'package:front/models/button/ButtonSlideAnimation.dart';
import 'package:front/entities/Notification.dart';
import '../../repository/api/ApiFcm.dart';

class AlertList extends StatefulWidget {
  const AlertList({Key? key}) : super(key: key);

  @override
  State<AlertList> createState() => _AlertListState();
}
class _AlertListState extends State<AlertList> {
  List<Notificate> notifications = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  void fetchGroups() async {
    setState(() {
      isLoading = true;
    });
    final notificationsJson = await sendNotiPersonal(); // API 호출
    if (notificationsJson != null && notificationsJson.data is List) {
      setState(() {
        notifications = (notificationsJson.data as List)
            .map((item) => Notificate.fromJson(item))
            .toList(); // 데이터 파싱
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("알람 데이터를 불러오는 데 실패했습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('알림 리스트'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.content),
          );
        },
      ),
    );
  }
}