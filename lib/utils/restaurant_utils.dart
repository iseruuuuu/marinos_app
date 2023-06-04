class RestaurantUtils {
  String getNumber(String phoneNumber) {
    String japanPhoneNumber = "0${phoneNumber.substring(3)}";
    String formattedPhoneNumber;
    if (japanPhoneNumber.length == 10) {
      formattedPhoneNumber =
          japanPhoneNumber.replaceRange(3, 3, "-").replaceRange(7, 7, "-");
      return formattedPhoneNumber;
    } else if (japanPhoneNumber.length == 9) {
      formattedPhoneNumber =
          japanPhoneNumber.replaceRange(2, 2, "-").replaceRange(6, 6, "-");
      return formattedPhoneNumber;
    }
    return phoneNumber;
  }
}
