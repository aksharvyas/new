import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static LocalStorageService? getInstance() {
    _instance ??= LocalStorageService();
    return _instance;
  }

  static onLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static final String name = "defaultName";
  static final String PREF_USER = "name";
  static final String PREF_IMAGE = "image";
  static final String PREF_APPID = "appID";
  static final String PREF_USERID = "userID";
  static final String PREF_TOKEN = "token";
  static final String FIREBASE_TOKEN = "tokenFirebase";
  static final String PREF_PHOTO_URL = "filename";
  static final String PREF_IS_FIRST_TIME = "isFirstTime";
  static final String PREF_TARGET = "target";
  static final String PREF_REGISTER = "false";
  static final String PREF_VIDEO = "video";
  static final String PREF_STATUS = "status";
  static final String PREF_LAST_CONTACT_NUMBER = "lastNumber";
  static final String PREF_EMAIL = "email";
  static final String PREF_PASSWORD = "password";
  static final String PREF_GENDER = "gender";
  static final String lastPageName = "lastPageName";
  static final String isPushValue = "isPushValue";
  static final String isEmailValue = "isEmailValue";
  static final String isAutoReply = "isAutoReply";
  static final String isActiveSubScription = "isActiveSubScription";
  static final String PREF_REFTOKEN = "PREF_REFTOKEN";
  static final String PREF_EXPIREDATE = "PREF_EXPIREDATE";
  static final String PREF_USERTYPId = "PREF_USERTYPEId";
  static final String PREF_LOCATIONNAME = "PREF_LOCATIONNAME";
  static final String PREF_LOCATIOLAT = "PREF_LOCATIOLAT";
  static final String PREF_LOCATIONLANG = "PREF_LOCATIONLANG";
  static final String PREF_WIFI = "PREF_WIFI";
  static final String PREF_WIFIPASSWORD = "PREF_WIFIPASSWORD";
  static final String PREF_MOBILENUMBER = "PREF_MOBILENUMBER";

  Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user language code, 'en' if not set
  /// ------------------------------------------------------------
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(name) ?? 'default';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(name, value);
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_TOKEN, value);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_TOKEN);
  }

  static Future<bool> setMobileNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_MOBILENUMBER, value);
  }

  static Future<String?> getMobileNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_MOBILENUMBER);
  }

  static Future<bool> setWifi(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_WIFI, value);
  }

  static Future<String?> getWifi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_WIFI);
  }

  static Future<bool> setWifiPassword(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_WIFIPASSWORD, value);
  }

  static Future<String?> getWifiPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_WIFIPASSWORD);
  }

  static Future<bool> setAppId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_APPID, value);
  }

  static Future<String?> getAppId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_APPID);
  }

  static Future<bool> setExpireDate(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_EXPIREDATE, value);
  }

  static Future<String?> getExpireDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_EXPIREDATE);
  }

  static Future<bool> setRefToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_REFTOKEN, value);
  }

  static Future<String?> getRefToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_REFTOKEN);
  }

  static Future<bool> setLocationName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_LOCATIONNAME, value);
  }

  static Future<String?> getLocationName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_LOCATIONNAME);
  }

  static Future<bool> setLocatioLAT(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setDouble(PREF_LOCATIOLAT, value);
  }

  static Future<double?> getLocationLAT() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(PREF_LOCATIOLAT);
  }

  static Future<bool> setLocatioLANG(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setDouble(PREF_LOCATIONLANG, value);
  }

  static Future<double?> getLocationLANG() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(PREF_LOCATIONLANG);
  }

  static Future<bool> setAutoReply(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(isAutoReply, value);
  }

  static Future<String?> getAutoReply() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(isAutoReply);
  }

  static Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_USER, value);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_USER);
  }

  static Future<bool> setUserImage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_IMAGE, value);
  }

  static Future<String?> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_IMAGE);
  }

  static Future<bool> setUserEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_EMAIL, value);
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_EMAIL) ?? null;
  }

  static Future<bool> setUserPassword(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_PASSWORD, value);
  }

  static Future<String?> getUserPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_PASSWORD);
  }

  static Future<bool> setFirebaseToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(FIREBASE_TOKEN, value);
  }

  static Future<bool> setIsActiveSubScription(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(isActiveSubScription, value);
  }

  static Future<bool?> getIsActiveSubScription() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(isActiveSubScription);
  }

  static Future<String?> getFirebaseToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(FIREBASE_TOKEN);
  }

  static Future<bool> setRegister(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(PREF_REGISTER, value);
  }

  static Future<bool?> getRegister() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(PREF_REGISTER);
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_USERID, value);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_USERID);
  }

  static Future<bool> setUserTypeId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_USERTYPId, value);
  }

  static Future<String?> getUserTypeId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_USERTYPId);
  }

  static Future<bool> setGender(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_GENDER, value);
  }

  static Future<String?> geGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_GENDER);
  }

  static Future<bool> setTarget(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_TARGET, value);
  }

  static Future<String?> getTarget() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_TARGET);
  }

  static Future<bool> setStatus(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(PREF_STATUS, value);
  }

  static Future<String?> getStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_STATUS);
  }

  static Future<bool> setPhotoUrl(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PREF_PHOTO_URL, value);
  }

  static Future<String?> getPhotoUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_PHOTO_URL);
  }

  static Future<bool> setIsFirstTime(bool isFirstTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PREF_IS_FIRST_TIME, isFirstTime);
  }

  static Future<bool?> getIsFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREF_IS_FIRST_TIME);
  }

  static Future<bool> setLastConctNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PREF_LAST_CONTACT_NUMBER, value);
  }

  static Future<String?> getLastConctNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_LAST_CONTACT_NUMBER);
  }

  static Future<bool> setLastPageOnApp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(lastPageName, value);
  }

  static Future<String?> getLastPageOnApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(lastPageName);
  }
}

const String MyProfileEditPagestr = "MyProfileEditPage";
const String HomePageStr = "HomePage";
