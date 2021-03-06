module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (Html, a, aside, div, h1, nav, text)
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


nav_header : Model -> Html Msg
nav_header model =
    nav
        [ class "navbar"
        , class "is-white"
        , attribute "role" "navigation"
        , attribute "aria-label" "main navigation"
        ]
        [ div [ class "container" ]
            [ div [ class "navbar-brand" ]
                [ a
                    [ class "navbar-item"
                    , attribute "href" "/"
                    ]
                    [ text "Cointool" ]
                ]
            ]
        , div
            [ id "mainNavbar"
            , class "navbar-menu"
            ]
            []
        ]


nav_menu : Model -> Html Msg
nav_menu model =
    div
        [ class "container" ]
        [ div [ class "columns" ]
            [ aside
                [ class "column"
                , class "is-2"
                , class "aside"
                , class "is-primary"
                , class "has-shadow"
                ]
                [ a
                    [ class "item"
                    , href "/tools/psc"
                    ]
                    [ text "Position Size Calculator" ]
                ]
            , div [ class "column" ]
                [ div [ id "main-content" ]
                    []
                ]
            ]
        ]


nav_section : Model -> Html Msg
nav_section model =
    div []
        [ nav_header model
        , nav_menu model
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
