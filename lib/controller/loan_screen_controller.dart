import 'package:cred_stack/model/loan_data_model.dart';
import 'package:cred_stack/services/load_data_api.dart';
import 'package:cred_stack/utils/curreny_converter.dart';
import 'package:get/get.dart';

class LoanScreenController extends GetxController {
  var activeTab = 0.obs;
  String loanAmount = "";
  RxInt planSelected = 0.obs;
  RxBool isDataLoaded = false.obs;
  late LoanDataModel loanData;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future fetchData() async {
    try {
      loanData = await ApiService.fetchData();
      loanAmount = convertCurrencyIntoString(loanData.items![0].openState!.body!.card!.minRange!.toStringAsFixed(0));
      isDataLoaded.value = true;
    } catch (e) {
      print("Error: $e");
    }
  }
}
