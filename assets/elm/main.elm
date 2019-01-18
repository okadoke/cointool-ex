import Browser
import Html exposing (Html, div, text, h1)


-- Model

type alias Model = 
  { 
    ticker: String
  }

model : Model
model = 
  {
    ticker = "BTC/USD"
  }

-- Update

type Msg
  = ToUpper
  | ToLower

update msg m =
  case msg of
    ToUpper ->
      (String.toUpper m.ticker)
    ToLower ->
      (String.toLower m.ticker)

-- View

view : Model -> Html Msg
view m = 
  div []
      [ div [] [ text ToUpper ]
      ]