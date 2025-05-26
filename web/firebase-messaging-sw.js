// web/firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.1/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyDUhxJrsD6mik9F_fvO3DepiN6q3PlZvj0",
  authDomain: "pharmacy-icon.firebaseapp.com",
  projectId: "pharmacy-icon",
  messagingSenderId: "375123250763",
  appId: "1:375123250763:web:52409f6e924eca75cb47ce"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/icon-192.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
