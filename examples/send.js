
var apn = require('apn');

var options = {
  token: {
    key: "./APNsAuthKey_Y9JHHPYRM7.p8",
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
note.alert = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent gravida cursus facilisis. Etiam tincidunt mollis lectus quis interdum. Morbi et metus a metus fringilla mattis eget sit amet leo. Fusce accumsan lorem eu pharetra luctus. In hac habitasse platea dictumst. In efficitur pulvinar lacus, sed ornare lectus malesuada at. Phasellus et mi erat. Nunc commodo nisl id odio hendrerit blandit. Vestibulum sit amet mi sit amet libero venenatis venenatis. Praesent sit amet odio sem. Pellentesque nec euismod lectus.

Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla ut erat eget velit mollis vehicula. Curabitur blandit urna mauris, at iaculis nisl placerat non. Pellentesque feugiat, dui ac fringilla mollis, nulla ex auctor turpis, nec pellentesque nibh dui vitae lorem. Nam viverra varius tristique. Aliquam erat volutpat. Sed posuere eget est ut imperdiet. Mauris feugiat justo quis mollis aliquam. Nulla id enim a libero accumsan gravida. Fusce nec metus lobortis, auctor nisl et, pharetra ante.

Maecenas magna justo, tristique nec volutpat in, pretium consectetur tortor. Cras eleifend mauris sed justo imperdiet, vel auctor neque pellentesque. Fusce maximus porta sapien sed varius. Praesent ac risus in eros imperdiet mollis. Phasellus scelerisque dolor ac consectetur dignissim. Proin at varius erat, at mollis nisi. Curabitur hendrerit mauris vitae mauris dignissim, ut pulvinar metus dignissim. Pellentesque nisl metus, convallis quis velit at, scelerisque tincidunt ligula. Donec nisi tortor, maximus vitae nisi sed, tristique aliquet orci. Aliquam id leo orci. Aenean euismod molestie ipsum, a molestie mauris aliquam et. Cras gravida mauris libero, in gravida arcu tincidunt vitae.

Nam ac erat iaculis lectus dignissim convallis nec at mi. Aliquam pharetra, eros eu placerat feugiat, lectus metus dignissim lectus, nec condimentum eros urna id mauris. Aenean sagittis nunc porta nisi efficitur vehicula. Etiam eleifend aliquet feugiat. Aenean vitae consequat libero, sed fringilla augue. Vestibulum ultrices, metus vel semper aliquet, metus risus dictum magna, in rutrum libero nibh id augue. Nam faucibus nulla ut nisi fermentum venenatis. Donec mattis pulvinar fermentum. Suspendisse sit amet felis dolor. Nam ipsum est, commodo eu dolor in, volutpat auctor felis. Duis fringilla ipsum et velit faucibus, a luctus erat aliquam. Maecenas nec consectetur nisl, quis placerat ex. Curabitur laoreet nunc sed lorem pellentesque, non auctor arcu feugiat. Etiam at suscipit mauris. Praesent sagittis leo a molestie auctor. Donec cursus, lacus sit amet fringilla molestie, massa nulla viverra lacus, vel finibus mi turpis at justo.

Maecenas id eros vehicula, scelerisque nunc sit amet, placerat est. Sed tincidunt viverra urna ac venenatis. Sed eu rhoncus ipsum. Proin ultrices libero ac lorem dapibus, vel sollicitudin urna luctus. Suspendisse interdum elementum quam sit amet euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ornare porttitor eros ac dictum. Maecenas mattis sodales sapien vel efficitur.

Nulla justo purus, malesuada consequat tempor eget, malesuada a risus. Nam sed mattis purus, ut aliquet urna. Cras gravida dui in velit volutpat, vitae hendrerit risus consectetur. Vestibulum ornare tortor purus, et mattis eros tristique sit amet. Suspendisse potenti. Vestibulum felis lacus, commodo at mattis nec, venenatis vitae tortor. Ut imperdiet ornare ornare.
`;
note.title = "\uD83D\uDCE7 \u2709 You have a new message";
// note.subtitle = "Urgent!";
// note.category = "balance";
// note.payload = {'tableItems': [ "Ford", "BMW", "Fiat" ]};
note.topic = "ru.keegan.apnsTest.voip";
// note.collapseId = "collapseId";
// note.contentAvailable = 1;
// note.mutableContent = 1;

// note.threadId = "threadId";

apnProvider.send(note, deviceToken).then( (result) => {
      console.log("sent:", result.sent.length);
      console.log("failed:", result.failed.length);
      console.log(result.failed);
});



