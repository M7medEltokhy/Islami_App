import 'package:dio/dio.dart';
import 'package:islami/features/tabs/radio_tab/data/radio_model.dart';

class RadioRepo {
  Dio dio = Dio();

  Future<List<RadioModel>> getRadio() async {
    Response response = await dio.get(
      "https://www.mp3quran.net/api/v3/radios?language=ar",
    );
    List<dynamic> dataRadio = response.data["radios"];
    List<RadioModel> radioList = [];
    for (var radio in dataRadio) {
      RadioModel radioModel = RadioModel(
        name: radio["name"],
        url: radio["url"],
      );
      radioList.add(radioModel);
    }
    return radioList;
  }
}
