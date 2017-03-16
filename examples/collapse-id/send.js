
var apn = require('apn');

var options = {
  token: {
    key: "../APNsAuthKey_Y9JHHPYRM7.p8",
    keyId: "Y9JHHPYRM7",
    teamId: "QKNV954376"
  },
  production: false
};

var apnProvider = new apn.Provider(options);

let deviceToken = "714800B9F3FABD2FFA3513C49C2C89E36681A0ECBCBB488C52D0FD50899A6CA3"
// let deviceToken = "CFA3033864D7EBFB0F2EE6CEC90C7053D2BFBE159F6495D99114EDA9C2485F99"




var balance = ['mana 100', 'health 10', 'mana 80', 'health 30', 'mana 60', 'health 50','mana 0', 'health 100'];
var collapse = ['coll1', 'coll2', 'coll1', 'coll2', 'coll1', 'coll2', 'coll1', 'coll2'];


  var note = new apn.Notification();
  note.expiry = Math.floor(Date.now() / 1000) + 3600; // Expires 1 hour from now.
  note.topic = "ru.keegan.apnsTest";
  note.alert = "Your " + balance[process.argv[2]];
  note.collapseId = collapse[process.argv[2]];

  apnProvider.send(note, deviceToken).then( (result) => {
        console.log("sent:", result.sent.length);
        console.log("failed:", result.failed.length);
        console.log(result.failed);
        process.exit();
  });



