
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String message;
  final DateTime time;
  final bool isDriver;
  final DeliveryStatus deliveryStatus; // New property for delivery status

  ChatMessage({
    required this.message,
    required this.time,
    required this.isDriver,
    required this.deliveryStatus, // Include delivery status in constructor
  });
}

// Enum for delivery status
enum DeliveryStatus {
  sent,     // Single tick
  delivered, // Double tick (grey)
  seen,      // Double blue tick
}

class ChatDriverScreen extends StatefulWidget {
  const ChatDriverScreen({super.key});

  @override
  State<ChatDriverScreen> createState() => _ChatDriverScreenState();
}

class _ChatDriverScreenState extends State<ChatDriverScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool isMicEnabled = false;

  final List<ChatMessage> messages = [
    ChatMessage(
      message: 'Hello, I am on my way.',
      time: DateTime.now().subtract(const Duration(minutes: 15)),
      isDriver: true,
      deliveryStatus: DeliveryStatus.delivered,
    ),
    ChatMessage(
      message: 'Great, see you soon!, Bye dear friend',
      time: DateTime.now().subtract(const Duration(minutes: 12)),
      isDriver: false,
      deliveryStatus: DeliveryStatus.seen,
    ),
    ChatMessage(
      message: 'Traffic is a bit heavy.',
      time: DateTime(2024,10,06,12,30).subtract(const Duration(minutes: 7)),
      isDriver: true,
      deliveryStatus: DeliveryStatus.sent,
    ),
    ChatMessage(
      message: 'No problem, drive safe.',
      time: DateTime(2024,01,10,12,30).subtract(const Duration(minutes: 4)),
      isDriver: false,
      deliveryStatus: DeliveryStatus.seen,
    ),
  ];

  // Method to format the time for each message
  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  // Method to format the date headers
  String formatDate(DateTime time) {
    return DateFormat('dd MMM yyyy').format(time);
  }

  // Toggle the mic button state (enable/disable)
  void toggleMic() {
    setState(() {
      isMicEnabled = !isMicEnabled;
    });
  }

  // Method to send a message
  void sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          message: _messageController.text,
          time: DateTime.now(),
          isDriver: false, // Assuming the user is a passenger
          deliveryStatus: DeliveryStatus.sent, // Initial status when sent
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  bool isSameDay = index == 0 ||
                      formatDate(messages[index].time) !=
                          formatDate(messages[index - 1].time);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the date header if the message is from a different day
                      if (isSameDay)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              formatDate(message.time),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),

                      // Chat bubble for the message
                      Row(
                        mainAxisAlignment: message.isDriver
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: message.isDriver
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                constraints: const BoxConstraints(maxWidth: 250),
                                decoration: BoxDecoration(
                                  color: message.isDriver
                                      ? Colors.grey
                                      : fillInputColor,
                                  borderRadius: BorderRadius.circular(normalRadiusSize),
                                ),
                                child: Text(
                                  message.message,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              // Message timestamp with delivery status
                              Row(
                                mainAxisAlignment: message.isDriver
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                                children: [
                                  // Show delivery status
                                  Icon(
                                    _getDeliveryStatusIcon(message.deliveryStatus),
                                    size: 16,
                                    color: DeliveryStatus.seen == message.deliveryStatus?Colors.blue:Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    formatTime(message.time),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fillInputColor,
                      hintText: 'Write a message...',
                      suffixIcon: InkWell(
                        onTap: sendMessage,
                        child: const Icon(Icons.send, color: primaryColor),
                      ),
                    ),
                  ),
                ),
                10.width,
                CircleAvatar(
                  radius: 30,
                  backgroundColor: fillInputColor,
                  child: InkWell(
                    radius: 30,
                    onTap: toggleMic,
                    child: Icon(
                      isMicEnabled ? Icons.mic : Icons.mic_off,
                      color: isMicEnabled ? primaryColor : Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to get the delivery status icon
  IconData _getDeliveryStatusIcon(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.sent:
        return Icons.check; // Single tick icon
      case DeliveryStatus.delivered:
        return Icons.done_all; // Double tick icon
      case DeliveryStatus.seen:
        return Icons.done_all; // Double blue tick icon
      default:
        return Icons.check; // Default to single tick
    }
  }
}
