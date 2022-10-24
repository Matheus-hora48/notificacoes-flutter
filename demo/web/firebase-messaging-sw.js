importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyCVHFtNI74dyRaUzfebWptp4VfQrhow5ZY",
  authDomain: "notificacoes-firebase-3c4a7.firebaseapp.com",
  databaseURL: "https://notificacoes-firebase-3c4a7.firebaseapp.com",
  projectId: "notificacoes-firebase-3c4a7",
  storageBucket: "notificacoes-firebase-3c4a7.appspot.com",
  messagingSenderId: "113214106564",
  appId: "1:113214106564:web:d44c5ea60c934f2ef6d291",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});