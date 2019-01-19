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


type alias Model =
    { ticker : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { ticker = "BTC/USD"
      }
    , Cmd.none
    )



-- Update


type Msg
    = ToUpper
    | ToLower


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToUpper ->
            ( { ticker = String.toUpper model.ticker }
            , Cmd.none
            )

        ToLower ->
            ( { ticker = String.toLower model.ticker }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
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
