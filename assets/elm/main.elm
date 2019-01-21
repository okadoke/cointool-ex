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
    { tickers : List Ticker
    , capital : Maybe Float
    , pct_to_risk : Maybe Float
    , entry_price : Maybe Float
    , stop_price : Maybe Float
    , target_price : Maybe Float
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { tickers = [ "BTC/USD" ]
      , capital = Just 0.0
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


nav_section : Model -> Html Msg
nav_section model =
    nav
        [ class "navbar"
        , class "is-primary"
        , attribute "role" "navigation"
        , attribute "aria-label" "main navigation"
        ]
        [ div [ class "navbar-brand" ]
            [ a
                [ class "navbar-item"
                , attribute "href" "/"
                ]
                [ text "Cointool" ]
            , a
                [ class "navbar-burger"
                , attribute "role" "button"
                , attribute "aria-label" "menu"
                , attribute "aria-expanded" "false"
                , attribute "data-target" "mainNavbar"
                ]
                []
            ]
        , div
            [ id "mainNavbar"
            , class "navbar-menu"
            ]
            [ div [ class "navbar-start" ]
                [ div
                    [ class "navbar-item"
                    , class "has-dropdown"
                    , class "is-hoverable"
                    ]
                    [ div [ class "navbar-link" ]
                        [ a
                            [ attribute "href" "/tools/" ]
                            [ text "Tools" ]
                        ]
                    , div [ class "navbar-dropdown" ]
                        [ a
                            [ class "navbar-item"
                            , attribute "href" "/tools/psc"
                            ]
                            [ text "Position Size Calculator" ]
                        ]
                    ]
                ]
            ]
        ]


body_section : Model -> Html Msg
body_section model =
    div [ class "section" ]
        []


view : Model -> Html Msg
view model =
    div []
        [ nav_section model
        , body_section model
        ]
