module QRCode
  ( mkQRCodeSimple
  , mkQRCode
  , makeCode
  , clear
  , module QRCode.Types
  ) where

import QRCode.Types
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn1, Fn2, runFn1, runFn2)

foreign import mkQRCodeSimpleImpl :: forall eff. Fn2 String String (Eff (qrcode :: QRCODE | eff) QRCode)
foreign import mkQRCodeImpl :: forall eff. Fn2 String Config (Eff (qrcode :: QRCODE | eff) QRCode)
foreign import makeCodeImpl :: forall eff. Fn2 String QRCode (Eff (qrcode :: QRCODE | eff) QRCode)
foreign import clearImpl :: forall eff. Fn1 QRCode (Eff (qrcode :: QRCODE | eff) QRCode)

mkQRCodeSimple :: forall eff. String -> String -> (Eff (qrcode :: QRCODE | eff) QRCode)
mkQRCodeSimple = runFn2 mkQRCodeSimpleImpl

mkQRCode :: forall eff. String -> Config -> (Eff (qrcode :: QRCODE | eff) QRCode)
mkQRCode = runFn2 mkQRCodeImpl

makeCode :: forall eff. String -> QRCode -> (Eff (qrcode :: QRCODE | eff) QRCode)
makeCode = runFn2 makeCodeImpl

clear :: forall eff. QRCode -> (Eff (qrcode :: QRCODE | eff) QRCode)
clear = runFn1 clearImpl
