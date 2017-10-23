module Main where

import Prelude
import Control.Monad.Eff (Eff)

import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Except (runExcept)
import QRCode (QRCODE, clear, defaultConfig, makeCode, mkQRCode, mkQRCodeNode, mkQRCodeNodeSimple, mkQRCodeSimple)
import Data.Foreign (toForeign)
import Data.Maybe (Maybe(..), maybe)
import Data.Either (either)
import DOM (DOM)
import DOM.HTML.Types (htmlDocumentToNonElementParentNode, readHTMLElement)
import DOM.Node.Types (ElementId(..))
import DOM.HTML (window)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)

foreign import onLoad :: forall eff. Eff eff Unit -> Eff eff Unit

main :: forall e. Eff (console :: CONSOLE, qrcode :: QRCODE, dom :: DOM | e) Unit
main = onLoad $ void $ do
  _ <- mkQRCodeSimple "qrcode1" "http://example.com"
  qrcode2 <- mkQRCode "qrcode2" defaultConfig { text = "http://example.com", width = 128, height = 128 }
  qrcode3 <- mkQRCode "qrcode3" defaultConfig { text = "", width = 128, height = 128, colorDark = "#FF0000" }
  _ <- makeCode "http://www.google.com" qrcode3
  _ <- clear qrcode2

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
    <$> getElementById (ElementId id_) doc
  eitherToMaybe = either (const Nothing) Just
