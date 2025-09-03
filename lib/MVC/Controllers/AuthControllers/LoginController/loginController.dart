// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Logincontroller extends GetxController {

// final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';
import 'package:reclaim/appServices/getRouteNames.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class Logincontroller extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RxBool isLoading = false.obs;
//   final UserController controller = Get.put(UserController());

//   // new Controller

//   Future<void> login() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar("Error", "Email and password are required",
//           backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final response = await ApiService().postRequest("login", data: {
//         "email": email,
//         "password": password,
//       });

//       isLoading.value = false;

//       if (response != null && response.data["error"] == false) {
//         final userData = response.data["data"]["user"];
//         final token = response.data["data"]["token"];

//         final name = userData["profile_name"] ?? "";
//         final gender = userData["profile_gender"] ?? "";
//         final image = userData["profile_image"] ?? "";

//         // ✅ Save to SharedPreferences
//         await SharedPrefService.saveUserData(
//           id: userData["id"].toString(),
//           email: userData["email"],
//           deviceToken: userData["device_token"],
//           Name: name,
//           token: token,
//           gender: gender,
//           image: image,
//         );

//         // ✅ Update UI through UserController
//         controller.updateUserProfile(
//           name: name,
//           gender: gender,
//           image: image,
//         );

//         // ✅ Navigate to next screen
//         Get.toNamed(GetRouteNames.BottomnavbarView);
//       } else {
//         Get.snackbar(
//             "Login Failed", response!.data["message"] ?? "Invalid credentials",
//             backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Invalid credentials",
//           "In case of lost credential use Forget Password",
//           backgroundColor: Reclaimcolors.DisableText,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM);
//       print("Login Exception: $e");
//     }
//   }
// }

class LoginController extends GetxController {
  // Correct initialization
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final UserController controller = Get.put(UserController());
  RxBool isgoogleLoading = false.obs;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

//
  // Get the FCM token method
  Future<String?> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token"); // Log the token for testing
    return token;
  }

  // Future<void> googleSignIn() async {
  //   isLoading.value =
  //       true; // Assuming isLoading is an observable in your controller

  //   try {
  //     // Initiating Google sign-in
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser == null) {
  //       // If user cancels the sign-in process
  //       print("❌ Sign-in aborted by user.");
  //       return;
  //     }

  //     // Get authentication details
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Retrieve Google user details
  //     final String? email = googleUser.email;
  //     final String? name = googleUser.displayName ?? "User";
  //     final String? id = googleUser.id;
  //     final String? image = googleUser.photoUrl ?? "";
  //     final String provider = "google";

  //     // Print user details
  //     print("✅ Name: $name");
  //     print("📧 Email: $email");
  //     print("🆔 ID: $id");
  //     print("🖼️ Picture: $image");
  //     print("🔌 Provider: $provider");

  //     // Retrieve FCM token for the device
  //     String? fcmToken = await FirebaseMessaging.instance.getToken();

  //     // Print FCM token
  //     print("📱 FCM Token: $fcmToken");
  //   } catch (e) {
  //     // Handle errors during the sign-in process
  //     Get.snackbar("Error", "Something went wrong: $e");
  //     print("🔥 Google Sign-In Error: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> googleSignIn() async {
    isLoading.value = true;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("❌ Sign-in aborted by user.");
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String email = googleUser.email;
      final String name = googleUser.displayName ?? "User";
      final String googleId = googleUser.id;
      final String image = googleUser.photoUrl ?? "";
      final String provider = "google";

      // Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // Call your backend
      final response = await ApiService().postRequest("google-login", data: {
        "provider": provider,
        "email": email,
        "name": name,
        "google_id": googleId,
        "device_token": fcmToken ?? "",
      });

      isLoading.value = false;

      if (response != null && response.data["error"] == false) {
        final data = response.data["data"];
        final user = data["user"];
        final token = data["token"];
        final userId = user["id"].toString();

        // ✅ If onboarding completed (profile_status exists)
        if (user.containsKey("profile_status")) {
          final email = user["email"] ?? "";
          final image = user["profile_image"] ?? "";
          final name = user["profile_name"] ?? "";
          final gender = user["profile_gender"] ?? "";
          final deviceToken = user["device_token"] ?? "";

          // Save to local storage
          await SharedPrefService.saveUserData(
            id: userId,
            email: email,
            token: token,
            image: image,
            Name: name,
            gender: gender,
            deviceToken: deviceToken,
          );

          Get.find<UserController>().updateUserProfile(
            name: name,
            gender: gender,
            image: image,
          );

          Get.toNamed(GetRouteNames.BottomnavbarView);
        } else {
          // ❌ Onboarding NOT completed
          Get.find<UserController>().setUserId(userId);
          Get.offNamed(GetRouteNames.Profilesetup);
        }
      } else {
        Get.snackbar("Error", response?.data["message"] ?? "Login failed");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
      print("🔥 Google Sign-In Error: $e");
    }
  }

//   Future<void> signInWithApple() async {
//   try {
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );

//     // Retrieve and print the user's information directly from the credential
//     final String? email = credential.email;
//     final String? name = credential.givenName; 
//     final String? appleToken = credential.identityToken;

//     print('Apple Sign-in successful!');
//     print('User Email: $email');
//     print('User Name: $name');
//     print('Identity Token: $appleToken');
    
//   } catch (e) {
//     print('Error during Apple Sign-in: $e');
//   }
// }


// Future<void> signInWithApple() async {
//   isLoading.value = true;

//   try {
//     // Request Apple credentials
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );

//     final String email = credential.email ?? ""; // May be null after first login
//     final String name = credential.givenName ?? credential.familyName ?? "User";
//     final String appleId = credential.userIdentifier ?? "";
//     final String provider = "apple";

//     // Apple provides identityToken (JWT)
//     final String? appleToken = credential.identityToken;

//     // ✅ Get FCM token
//     String? fcmToken = await FirebaseMessaging.instance.getToken();

//     // ✅ Call your backend
//     final response = await ApiService().postRequest("auth/apple", data: {
//       "provider": provider,
//       "email":"dev.hboxdigital@gmail.com",
//       //  email,
//       "name": "HBOX",
//       // name,
//       // "apple_id": appleId,
//       "identity_token": appleToken ?? "",
//       "device_token": fcmToken ?? "",
//     });

//     isLoading.value = false;

//     if (response != null && response.data["error"] == false) {
//       final data = response.data["data"];
//       final user = data["user"];
//       final token = data["token"];
//       final userId = user["id"].toString();

//       // ✅ If onboarding completed (profile_status exists)
//       if (user.containsKey("profile_status")) {
//         final email = user["email"] ?? "";
//         final image = user["profile_image"] ?? "";
//         final name = user["profile_name"] ?? "";
//         final gender = user["profile_gender"] ?? "";
//         final deviceToken = user["device_token"] ?? "";

//         // Save to local storage
//         await SharedPrefService.saveUserData(
//           id: userId,
//           email: email,
//           token: token,
//           image: image,
//           Name: name,
//           gender: gender,
//           deviceToken: deviceToken,
//         );

//         Get.find<UserController>().updateUserProfile(
//           name: name,
//           gender: gender,
//           image: image,
//         );

//         Get.toNamed(GetRouteNames.BottomnavbarView);
//       } else {
//         // ❌ Onboarding NOT completed
//         Get.find<UserController>().setUserId(userId);
//         Get.offNamed(GetRouteNames.Profilesetup);
//       }
//     } else {
//       Get.snackbar("Error", response?.data["message"] ?? "Login failed");
//     }
//   } catch (e) {
//     isLoading.value = false;
//     Get.snackbar("Error", "Something went wrong: $e");
//     print("🔥 Apple Sign-In Error: $e");
//   }
// }

Future<void> signInWithApple() async {
  isLoading.value = true;

  try {
    // Request Apple credentials
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Always fallback to empty string if null
    final String email = credential.email ?? "";
    final String name = credential.givenName ?? credential.familyName ?? "User";
    final String appleId = credential.userIdentifier ?? "";
    final String provider = "apple";
    final String? appleToken = credential.identityToken;

    if (appleToken == null || appleToken.isEmpty) {
      throw Exception("Apple identity token is missing.");
    }

    // ✅ Get FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    // ✅ Call your backend
    final response = await ApiService().postRequest("auth/apple", data: {
      "provider": provider,
      "apple_id": appleId,
      "identityToken": appleToken,
      "email": email, // <-- sends "" if missing
      "name": name,   // <-- sends "User" if missing
      "device_token": fcmToken ?? "",
    });

    isLoading.value = false;

    if (response != null && response.data["error"] == false) {
      final data = response.data["data"];
      final user = data["user"];
      final token = data["token"];
      final userId = user["id"].toString();

      if (user.containsKey("profile_status")) {
        final email = user["email"] ?? "";
        final image = user["profile_image"] ?? "";
        final name = user["profile_name"] ?? "";
        final gender = user["profile_gender"] ?? "";
        final deviceToken = user["device_token"] ?? "";

        await SharedPrefService.saveUserData(
          id: userId,
          email: email,
          token: token,
          image: image,
          Name: name,
          gender: gender,
          deviceToken: deviceToken,
        );

        Get.find<UserController>().updateUserProfile(
          name: name,
          gender: gender,
          image: image,
        );

        Get.toNamed(GetRouteNames.BottomnavbarView);
      } else {
        Get.find<UserController>().setUserId(userId);
        Get.offNamed(GetRouteNames.Profilesetup);
      }
    } else {
      Get.snackbar("Error", response?.data["message"] ?? "Login failed");
    }
  } catch (e) {
    isLoading.value = false;
    Get.snackbar("Error", "Something went wrong: $e");
    print("🔥 Apple Sign-In Error: $e");
  }
}



  // Future<void> googleSignIn() async {
  //   isLoading.value =
  //       true; // Assuming isLoading is an observable in your controller

  //   try {
  //     // Initiating Google sign-in
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser == null) {
  //       // If user cancels the sign-in process
  //       print("❌ Sign-in aborted by user.");
  //       return;
  //     }

  //     // Get authentication details
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Retrieve Google user details
  //     final String? email = googleUser.email;
  //     final String? name = googleUser.displayName ?? "User";
  //     final String? id = googleUser.id;
  //     final String? image = googleUser.photoUrl ?? "";
  //     final String provider = "google";

  //     // Print user details
  //     print("✅ Name: $name");
  //     print("📧 Email: $email");
  //     print("🆔 ID: $id");
  //     print("🖼️ Picture: $image");
  //     print("🔌 Provider: $provider");

  //     // Retrieve Google OAuth token (idToken)
  //     final String? googleIdToken =
  //         googleAuth.idToken; // This is the Google OAuth token
  //     print("🗝️ Google OAuth Token (idToken): $googleIdToken");

  //     // Retrieve FCM token for the device
  //     String? fcmToken = await FirebaseMessaging.instance.getToken();

  //     // Print FCM token
  //     print("📱 FCM Token: $fcmToken");
  //   } catch (e) {
  //     // Handle errors during the sign-in process
  //     Get.snackbar("Error", "Something went wrong: $e");
  //     print("🔥 Google Sign-In Error: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Login method
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      // Get FCM Token
      String? fcmToken = await getFCMToken();

      // Send login request along with FCM token
      final response = await ApiService().postRequest("login", data: {
        "email": email,
        "password": password,
        "device_token": fcmToken, // Add device_token to the body
      });

      isLoading.value = false;

      if (response != null && response.data["error"] == false) {
        final userData = response.data["data"]["user"];
        final token = response.data["data"]["token"];

        final name = userData["profile_name"] ?? "";
        final gender = userData["profile_gender"] ?? "";
        final image = userData["profile_image"] ?? "";

        // ✅ Save to SharedPreferences
        await SharedPrefService.saveUserData(
          id: userData["id"].toString(),
          email: userData["email"],
          deviceToken: userData["device_token"],
          Name: name,
          token: token,
          gender: gender,
          image: image,
        );

        // ✅ Update UI through UserController
        controller.updateUserProfile(
          name: name,
          gender: gender,
          image: image,
        );

        // ✅ Navigate to next screen
        Get.toNamed(GetRouteNames.BottomnavbarView);
      } else {
        Get.snackbar(
            "Login Failed", response!.data["message"] ?? "Invalid credentials",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Invalid credentials",
          "In case of lost credentials use Forget Password",
          backgroundColor: Colors.grey,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      print("Login Exception: $e");
    }
  }

  // with Google(),

  // Google Sign-In method
  // Future<void> signInWithGoogle() async {
  //   isLoading.value = true;

  //   try {
  //     // Trigger the Google Sign-In flow
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     if (googleUser == null) {
  //       // User canceled the sign-in process
  //       isLoading.value = false;
  //       return;
  //     }

  //     // Obtain the Google authentication details
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     // Create a new credential
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase using the Google credentials
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);

  //     final user = userCredential.user;

  //     // Save the user data to SharedPreferences
  //     if (user != null) {
  //       final userName = user.displayName ?? "";
  //       final userEmail = user.email ?? "";
  //       final userPhotoUrl = user.photoURL ?? "";

  //       // Save the user data
  //       await SharedPrefService.saveUserData(
  //         id: user.uid,
  //         email: userEmail,
  //         deviceToken: "", // You can pass the FCM token here if available
  //         Name: userName,
  //         token: "", // You can store Firebase ID token if needed
  //         gender: "", // Gender (if available)
  //         image: userPhotoUrl,
  //       );

  //       // Update the UserController with the user's profile info
  //       controller.updateUserProfile(
  //         name: userName,
  //         gender: "", // Gender (if available)
  //         image: userPhotoUrl,
  //       );

  //       // Navigate to the home screen after successful login
  //       Get.toNamed(GetRouteNames.BottomnavbarView);
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar("Error", "Failed to sign in with Google: $e",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     print("Google Sign-In Error: $e");
  //   }
  // }
}
