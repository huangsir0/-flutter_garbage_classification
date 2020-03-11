const ME = 1;
const OTHER = 0;
const TYPE_TEXT = 1;

class ChatMessage {
  int id;
  String avator;
  String content;
  int type_user; //1：自己 0：对方
  String user_name;
  String date;

  ChatMessage(user_name, type_user, content) {
    this.user_name = user_name;
    this.type_user = type_user;
    this.content = content;
  }
}
