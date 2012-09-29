// require.config({
//   urlArgs: "bust=" +  (new Date()).getTime(),


//   basePath: "/",
//   paths: {
//     "test": "/test/spec",
//     "app": "/../apfp"
//   },
//   shim: {
//     backbone: {
//       deps: ["underscore", "jquery"],
//       exports: "Backbone"
//     }
//   }
// });

// window.addEventListener("load", function onLoad() {
//   var jasmineEnv = jasmine.getEnv(),
//   reporter = new jasmine.TrivialReporter();

//   jasmineEnv.addReporter(reporter);
//   setTimeout(function () {
//     jasmineEnv.execute();
//        // Without this setTimeout, the specs don't always get execute in webKit browsers, I don't know why
//   }, 10);
//   window.removeEventListener("load", onLoad, true);
// }, true);

// require(["test/test"], function(Range) {
//   console.log("s", Range);
//   // body...
// });