import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeDotenv() async {
  await dotenv.load(fileName: ".env");
}
