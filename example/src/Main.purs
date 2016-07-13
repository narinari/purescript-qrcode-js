module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import QRCode

foreign import onLoad :: forall eff. Eff eff Unit -> Eff eff Unit

main :: forall e. Eff (console :: CONSOLE, qrcode :: QRCODE | e) Unit
main = onLoad $ void $ do
  mkQRCodeSimple "qrcode1" "http://example.com"
  qrcode2 <- mkQRCode "qrcode2" defaultConfig { text = "http://example.com", width = 128, height = 128 }
  qrcode3 <- mkQRCode "qrcode3" defaultConfig { text = "", width = 128, height = 128, colorDark = "#FF0000" }
  makeCode "http://www.google.com" qrcode3
  clear qrcode2
