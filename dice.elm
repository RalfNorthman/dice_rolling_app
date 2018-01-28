module Main exposing (..)

import Color
import Html exposing (Html, pre, div, program)
import Element.Events exposing (onClick)
import Element exposing (..)
import Element.Attributes exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font
import Random
import Char


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subs
        }



-- MODEL


type alias Model =
    List Int


init : ( Model, Cmd Msg )
init =
    ( [ 1, 1, 1 ], Cmd.none )



-- UPDATE


dieRoll : Random.Generator Int
dieRoll =
    Random.int 1 6


rollDice : Random.Generator (List Int)
rollDice =
    Random.list 3 dieRoll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFaces rollDice )

        NewFaces list ->
            ( list, Cmd.none )



-- SUBS


subs : model -> Sub msg
subs model =
    Sub.none



-- VIEW


type Msg
    = Roll
    | NewFaces (List Int)


dieFaceIcon : Int -> String
dieFaceIcon dieResult =
    dieResult
        + 9855
        |> Char.fromCode
        |> String.fromChar


dieFacesText : Model -> String
dieFacesText model =
    model
        |> List.map dieFaceIcon
        |> String.concat


sumDice : Model -> String
sumDice model =
    model
        |> List.sum
        |> toString
        |> (\s -> String.padLeft 3 ' ' s)


view : Model -> Html Msg
view model =
    layout stylesheet
        (row MyRowStyle
            [ padding 10, spacing 7 ]
            [ el MyStyle [] (model |> dieFacesText |> text)
            , el MyStyle [] (model |> sumDice |> text)
            , button MyStyle [ onClick Roll ] (text "Roll")
            ]
        )



-- STYLE


type MyStyles
    = Title
    | MyRowStyle
    | MyStyle


stylesheet =
    styleSheet
        [ style Title
            [ Color.text Color.darkGrey
            , Color.background Color.white
            , Font.size 5
            , Font.typeface
                [ Font.font "Helvetica"
                , Font.font "Comic Sans"
                , Font.font "Papyrus"
                ]
            ]
        , style MyRowStyle
            []
        , style MyStyle
            []
        ]
