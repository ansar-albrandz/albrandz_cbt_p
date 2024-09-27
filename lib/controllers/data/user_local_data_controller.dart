import 'package:albrandz_cbt_p/views/utils/helpers/shared_preference_helper.dart';

const isLoggedInKey = "isLoggedIn";
const isLogInTokenKey = "loginToken";

class UserLocalDataController extends SharedPreferenceHelper{

  storeLoginToken(String token)async{
    await addString(key: isLogInTokenKey, value: token);
  }
  
  Future<String?> getLoginToken()async{
    return await getString(key: isLogInTokenKey);
  }

  storeLogInStatus({bool value = true})async{
    await addBoolean(key: isLoggedInKey, value: value);
  }

  Future<bool>isLogIn()async{
    return await getBoolean(key: isLoggedInKey)??false;
  }

}