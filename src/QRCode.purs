module QRCode
  ( mkQRCodeSimple
  , mkQRCode
  , mkQRCodeNodeSimple
  , mkQRCodeNode
  , makeCode
  , clear
  , module QRCode.Types
  ) where

import QRCode.Types
import Control.Monad.Eff (Eff)
import Data.Function.Eff (EffFn1, EffFn2, runEffFn1, runEffFn2)

import DOM.HTML.Types (HTMLElement)

foreign import mkQRCodeSimpleImpl :: forall eff. EffFn2 (qrcode :: QRCODE | eff) String String QRCode
foreign import mkQRCodeImpl :: forall eff. EffFn2 (qrcode :: QRCODE | eff) String Config QRCode
foreign import mkQRCodeNodeSimpleImpl :: forall eff. EffFn2 (qrcode :: QRCODE | eff) HTMLElement String QRCode
foreign import mkQRCodeNodeImpl :: forall eff. EffFn2 (qrcode :: QRCODE | eff) HTMLElement Config QRCode
foreign import makeCodeImpl :: forall eff. EffFn2 (qrcode :: QRCODE | eff) String QRCode QRCode
foreign import clearImpl :: forall eff. EffFn1 (qrcode :: QRCODE | eff) QRCode QRCode

mkQRCodeSimple :: forall eff. String -> String -> Eff (qrcode :: QRCODE | eff) QRCode
mkQRCodeSimple = runEffFn2 mkQRCodeSimpleImpl

mkQRCode :: forall eff. String -> Config -> Eff (qrcode :: QRCODE | eff) QRCode
mkQRCode = runEffFn2 mkQRCodeImpl

mkQRCodeNodeSimple :: forall eff. HTMLElement -> String -> Eff (qrcode :: QRCODE | eff) QRCode
mkQRCodeNodeSimple = runEffFn2 mkQRCodeNodeSimpleImpl

mkQRCodeNode :: forall eff. HTMLElement -> Config -> Eff (qrcode :: QRCODE | eff) QRCode
mkQRCodeNode = runEffFn2 mkQRCodeNodeImpl

makeCode :: forall eff. String -> QRCode -> Eff (qrcode :: QRCODE | eff) QRCode
makeCode = runEffFn2 makeCodeImpl

clear :: forall eff. QRCode -> Eff (qrcode :: QRCODE | eff) QRCode
clear = runEffFn1 clearImpl
