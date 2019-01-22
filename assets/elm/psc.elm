module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (Html, a, div, h1, nav, text)
import Html.Attributes exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Model


type alias Ticker =
    String


type alias Model =
    { capital : Maybe Float
    , pct_to_risk : Maybe Float
    , entry_price : Maybe Float
    , stop_price : Maybe Float
    , target_price : Maybe Float
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { capital = Just 0.0
      , pct_to_risk = Just 1.0
      , entry_price = Just 0.0
      , stop_price = Just 0.0
      , target_price = Just 0.0
      }
    , Cmd.none
    )



-- Update


type Msg
    = SetCapital String
    | SetPctToRisk String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCapital str ->
            ( { model | capital = String.toFloat str }, Cmd.none )

        SetPctToRisk str ->
            ( { model | pct_to_risk = String.toFloat str }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        []
