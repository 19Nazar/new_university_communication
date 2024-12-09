// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyC90gQD2u9D5jrtkfLRi-tICXTZHJSo6aY",
  authDomain: "new-university-communication.firebaseapp.com",
  projectId: "new-university-communication",
  storageBucket: "new-university-communication.firebasestorage.app",
  messagingSenderId: "1044858124129",
  appId: "1:1044858124129:web:121410f0e9d7cd45d9f720"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});