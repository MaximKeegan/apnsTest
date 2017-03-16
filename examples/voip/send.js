
var apn = require('apn');

var options = {
  token: {
    key: "../APNsAuthKey_Y9JHHPYRM7.p8",
    keyId: "Y9JHHPYRM7",
    teamId: "QKNV954376"
  },
  voip: true,
  production: false
};

var apnProvider = new apn.Provider(options);

// let deviceToken = "714800B9F3FABD2FFA3513C49C2C89E36681A0ECBCBB488C52D0FD50899A6CA3"
let deviceToken = "CFA3033864D7EBFB0F2EE6CEC90C7053D2BFBE159F6495D99114EDA9C2485F99"


var note = new apn.Notification();

note.expiry = Math.floor(Date.now() / 1000) + 3600; // Expires 1 hour from now.
// note.badge = 1;
// note.sound = "ping.aiff";
note.alert = "Maxim just uploaded picture";
note.payload = {'image': "https://www.gravatar.com/avatar/706ff3585fe37c5f1e761413abe3041b?s=300"};
note.topic = "ru.keegan.apnsTest.voip";
note.mutableContent = 1;

apnProvider.send(note, deviceToken).then( (result) => {
      console.log("sent:", result.sent.length);
      console.log("failed:", result.failed.length);
      console.log(result.failed);
      process.exit();
});



