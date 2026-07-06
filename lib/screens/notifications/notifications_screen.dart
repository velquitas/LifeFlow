import 'package:flutter/material.dart';

import '../../models/app_notification.dart';
import '../../services/notification_center_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<AppNotification> notifications =
        NotificationCenterService.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: "Mark all as read",
            onPressed: () {
              setState(() {
                NotificationCenterService.markAllAsRead();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: "Clear all",
            onPressed: () {
              setState(() {
                NotificationCenterService.clear();
              });
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "You're all caught up!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "No notifications yet.",
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification =
                    notifications[index];

                return Dismissible(
                  key: ValueKey(notification.id),
                  direction:
                      DismissDirection.endToStart,
                  onDismissed: (_) {
                    setState(() {
                      NotificationCenterService.remove(
                        notification.id,
                      );
                    });
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        notification.read
                            ? Icons.notifications_none
                            : Icons.notifications,
                      ),
                    ),
                    title: Text(notification.title),
                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(notification.message),
                        const SizedBox(height: 4),
                        Text(
                          notification.date.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: notification.read
                        ? null
                        : const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.blue,
                            size: 12,
                          ),
                    onTap: () {
                      setState(() {
                        NotificationCenterService
                            .markAsRead(
                          notification.id,
                        );
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}