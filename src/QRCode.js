'use strict';

exports.mkQRCodeSimpleImpl = function (elm, content) {
    return new QRCode(document.getElementById(elm), content);
};

exports.mkQRCodeImpl = function (elm, config) {
    return new QRCode(document.getElementById(elm), config);
};

exports.mkQRCodeNodeSimpleImpl = function (node, content) {
    return new QRCode(node, content);
};

exports.mkQRCodeNodeImpl = function (node, config) {
    return new QRCode(node, config);
};

exports.makeCodeImpl = function (text, self) {
    return self.makeCode(text);
};

exports.clearImpl = function (self) {
    return self.clear();
};
