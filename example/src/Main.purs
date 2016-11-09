module Main where

import Prelude
import Control.Monad.Eff (Eff)

import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Except (runExcept)
import QRCode

import Data.Nullable (toMaybe)
import Data.Foreign (toForeign)
import Data.Maybe (Maybe(..), maybe)
import Data.Either (either)
import DOM (DOM)
import DOM.HTML.Types
import DOM.Node.Types
import DOM.HTML (window)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)

foreign import onLoad :: forall eff. Eff eff Unit -> Eff eff Unit

main :: forall e. Eff (console :: CONSOLE, qrcode :: QRCODE, dom :: DOM | e) Unit
main = onLoad $ void $ do
  mkQRCodeSimple "qrcode1" "http://example.com"
  qrcode2 <- mkQRCode "qrcode2" defaultConfig { text = "http://example.com", width = 128, height = 128 }
  qrcode3 <- mkQRCode "qrcode3" defaultConfig { text = "", width = 128, height = 128, colorDark = "#FF0000" }
  makeCode "http://www.google.com" qrcode3
  clear qrcode2

  doc <- htmlDocumentToNonElementParentNode <$> (window >>= document)

  qrcode4Elm <- getHTMLElement "qrcode4" doc
  qrcode5Elm <- getHTMLElement "qrcode5" doc

  maybe (pure unit) (_ $> unit)
    $ flip mkQRCodeNodeSimple "http://example.com" <$> qrcode4Elm
  maybe (pure unit) (_ $> unit)
    $ flip mkQRCodeNode defaultConfig { text = "http://example.com"
                                      , width = 128
                                      , height = 128
                                      , colorDark = "#00FF00" }
    <$> qrcode5Elm

  where
  getHTMLElement id_ doc =
    (eitherToMaybe <=< (map $ runExcept <<< readHTMLElement <<< toForeign))
    <$> toMaybe
    <$> getElementById (ElementId id_) doc
  eitherToMaybe = either (const Nothing) Just
