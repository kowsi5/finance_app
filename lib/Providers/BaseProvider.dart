import 'package:finance_app/core/utils/Constants.dart';
import '../core/provider/CoreBaseProvider.dart';

class BaseProvider extends CoreBaseProvider {
  Map<String, String> registerForm = {};
  bool isLocationFetching = true;
  bool isShowFilter = false;
  String filePath1 = "";

  // final AudioPlayer _audioPlayer = AudioPlayer();
  // List<ResAssets> playlist = [];
  int currentIndex = -1;
  bool isPlaying = false;

  // AudioPlayer get audioPlayer => _audioPlayer;

  BaseProvider(context, screen, data) : super(context, null) {
    // format2025Menu1();
    isAPILoading = true;
    isLocationFetching = true;
    isShowFilter = false;
    if (screen == "register") {}
    if (screen == "முகப்பு") {}
    if (screen == "audio") {
      // accessAudioListList(data);
    }
  }

  updateRemoveSplash() {
    Constants.showSplash = false;
    notifyListeners();
  }

  //MainHome
  String selectedMenu = "Home";
  int bottomTabIndex = 0;

  int pageSize = 20;
  int currentPage = 0;
  bool hasMoreData = true;
  bool moreLoading = false;

  String currentScreen = "";

  reloadScreen() {
    notifyListeners();
  }

  updateScreen(String screen) {
    selectedMenu = screen;
    notifyListeners();
  }
}
