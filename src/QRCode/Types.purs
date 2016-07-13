module QRCode.Types where

foreign import data QRCODE :: !

data QRCode

type Config =
  { text :: String
  , width :: Int
  , height :: Int
  , colorDark :: String
  , colorLight :: String
  , typeNumber :: Int
  }

defaultConfig :: Config
defaultConfig =
  { text: ""
  , width: 256
  , height: 256
  , colorDark: "#000000"
  , colorLight: "#FFFFFF"
  , typeNumber: 4
  }