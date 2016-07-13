'use strict';

exports.mkQRCodeSimpleImpl = function (elm, content) {
  return function () {
    return new QRCode(document.getElementById(elm), content);
  };
};

exports.mkQRCodeImpl = function (elm, config) {
  return function () {
    return new QRCode(document.getElementById(elm), config);
  };
};

exports.makeCodeImpl = function (text, self) {
  return function () {
    return self.makeCode(text);
  };
};

exports.clearImpl = function (self) {
  return function () {
    return self.clear();
  };
};
