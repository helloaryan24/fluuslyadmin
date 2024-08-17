import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MessagesContoller extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    messages.addAll([
      {
        'name': 'Cameron Williamson',
        'date': '14:32',
        'message': 'omg, this is amazing',
        'avatar': 'https://i.pinimg.com/474x/57/7e/93/577e9312f00ea757ef2af5537e82b5e4.jpg',
        'unread': 1,
        'time': '14:32'
      },{
        'name': 'Alex Johnson',
        'date': '10:20',
        'message': 'Let\'s catch up soon!',
        'avatar': 'https://i.pinimg.com/736x/48/1e/69/481e6935d421cb287c48985b498e3cf8.jpg',
        'unread': 5,
        'time': '10:20'
      },
      {
        'name': 'Emily Davis',
        'date': '09:15',
        'message': 'Great job on the project!',
        'avatar': 'https://i.pinimg.com/736x/b1/f9/e7/b1f9e7e87e9e9068d45784af38c2cb54.jpg',
        'unread': 3,
        'time': '09:15'
      },
      {
        'name': 'Michael Brown',
        'date': 'Yesterday',
        'message': 'Check this out!',
        'avatar': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyGZ4UTJp_G_jZqTcaHRmT243H-ceccWs1KJwF2pUwwWvZnefce9fCfEXJoO1b9r_AkbQ&usqp=CAU',
        'unread': 1,
        'time': 'Yesterday'
      },
      {
        'name': 'Sarah Wilson',
        'date': 'Monday',
        'message': 'Can you send me the report?',
        'avatar': 'https://randomuser.me/api/portraits/women/4.jpg',
        'unread': 4,
        'time': 'Monday'
      },
      {
        'name': 'David Clark',
        'date': 'Last week',
        'message': 'How are you?',
        'avatar': 'https://i.pinimg.com/236x/b9/9b/86/b99b8649c4bf0c731693666ab8015c90.jpg',
        'unread': 0,
        'time': 'Last week'
      },
      // Add more messages here
    ]);
  }
}
