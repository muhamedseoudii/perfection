abstract class EndPoints {
  static const String baseUrl = "https://wahaj.dbs.com.sa/";


  //auth
  static const String loginUrl = "https://api.dbs.com.sa/auth/login";
  static const String addAuctionUrl =
      "https://api.dbs.com.sa/auctions/add-auction";
  static const String signupUrl = "https://api.dbs.com.sa/auth/signup";
  //auction
  static const String getAllAuctions =
      "https://api.dbs.com.sa/auctions/get-all-auctions";
  static String getUserList({required int page}) =>
      "https://reqres.in/api/users?page=$page";
  static String getPreviousAuction({required int id}) =>
      "https://api.dbs.com.sa/auctions/get-auction?auction_id=$id";
  static String getWinAuction({required int id}) =>
      "https://api.dbs.com.sa/auctions/get-winnings?user_id=$id";
  // ads
  static const String getHomeAds = "advertisements/get-home-advertisement";

// for test only
  static String deleteFromSaved({required int id}) => "deleteFavorite/$id";
}
