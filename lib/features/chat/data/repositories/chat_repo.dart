abstract class ChatRepo {
  Future<void> sendMessage(
      {required String receiverId,
      required String time,
      required String date,
      required Map<String, dynamic>? messageImage,
      required String text});
}
