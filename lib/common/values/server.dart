import 'package:flutter_cloud_music/common/utils/print_debug_output.dart';
import 'package:logger/logger.dart';

const SERVER_API_URL = 'http://localhost:3000';

// const SERVER_API_URL = 'https://netease-cloud-music-api-black-nu.vercel.app';

final logger = Logger(
  printer: PrettyPrinter(lineLength: 20),
  output: DebugPrintConsoleOutput(),
);
