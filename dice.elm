module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
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


dieFacesText : Model -> Html Msg
dieFacesText model =
    model
        |> List.map dieFaceIcon
        |> String.concat
        |> Html.text


sumDice : Model -> Html Msg
sumDice model =
    model
        |> List.sum
        |> toString
        |> (\s -> String.padLeft 4 ' ' s)
        |> Html.text


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ dieFacesText model, sumDice model ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]
