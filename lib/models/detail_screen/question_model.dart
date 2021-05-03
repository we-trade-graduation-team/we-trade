import 'answer_model.dart';

class Question {
  Question({
    required this.question,
    this.voteNumber = 0,
    this.answers,
  });

  final int voteNumber;
  final String question;
  final List<Answer>? answers;
}

List<Question> demoQuestions = [
  Question(
    voteNumber: 2,
    question: 'Can i play on my pc with this controller? Need a software?',
    answers: [
      Answer(
        answerUserId: 3,
        date: DateTime.utc(2021, 1, 4),
        answer:
            'Download STEAM. Steam has controller support. You can also download non steam games to steam. And play them through steam and ps4 controller works.',
      ),
      Answer(
        answerUserId: 4,
        date: DateTime.utc(2021, 1, 2),
        answer:
            'Does not need special software. Configure the joypad in whatever game you are playing using the controller.',
      ),
      Answer(
        answerUserId: 1,
        date: DateTime.utc(2021, 1, 2),
        answer:
            'It can be used to play on a PC but it does need special software. Try this address for software- http://forums.pcsx2.net/Thread-DS4-To-XInput-Wrapper',
      ),
    ],
  ),
  Question(
    question: 'CAN BE THE PS4 CONTROLLER USED FOR PS3?',
    answers: [
      Answer(
        answerUserId: 3,
        date: DateTime.utc(2021, 1, 4),
        answer:
            'Under "Accessory Settings", select "Manage Bluetooth Devices" Select "Register New Device" then start scanning While the PS3 is scanning, press and hold the share button and PS button on the DS4 at the same time until it starts blinking',
      ),
    ],
  ),
  Question(
    question: 'CAN BE THE PS4 CONTROLLER USED FOR PS3?',
    answers: [
      Answer(
        answerUserId: 3,
        date: DateTime.utc(2021, 1, 4),
        answer:
            'Under "Accessory Settings", select "Manage Bluetooth Devices" Select "Register New Device" then start scanning While the PS3 is scanning, press and hold the share button and PS button on the DS4 at the same time until it starts blinking',
      ),
    ],
  ),
  Question(
    question: 'CAN BE THE PS4 CONTROLLER USED FOR PS3?',
    answers: [
      Answer(
        answerUserId: 3,
        date: DateTime.utc(2021, 1, 4),
        answer:
            'Under "Accessory Settings", select "Manage Bluetooth Devices" Select "Register New Device" then start scanning While the PS3 is scanning, press and hold the share button and PS button on the DS4 at the same time until it starts blinking',
      ),
    ],
  ),
];
