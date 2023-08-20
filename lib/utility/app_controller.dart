import 'package:beemap/models/bee_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppController extends GetxController{
  
RxList<Position> positions = <Position>[].obs;

RxList<String> phoneNumbers = <String>[].obs;

RxList<BeeModel> beeModels = <BeeModel>[].obs;


}