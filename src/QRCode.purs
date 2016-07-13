module QRCode
  ( mkQRCodeSimple
  , mkQRCode
  , module QRCode.Types
  ) where

import QRCode.Types
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2)

foreign import mkQRCodeSimpleImpl :: forall eff. Fn2 String String (Eff (qrcode :: QRCODE | eff) QRCode)
foreign import mkQRCodeImpl :: forall eff. Fn2 String Config (Eff (qrcode :: QRCODE | eff) QRCode)

mkQRCodeSimple :: forall eff. String -> String -> (Eff (qrcode :: QRCODE | eff) QRCode)
mkQRCodeSimple = runFn2 mkQRCodeSimpleImpl

mkQRCode :: forall eff. String -> Config -> (Eff (qrcode :: QRCODE | eff) QRCode)
mkQRCode = runFn2 mkQRCodeImpl
