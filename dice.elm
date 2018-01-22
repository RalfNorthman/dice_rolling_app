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
    { dieFaceOne : Int
    , dieFaceTwo : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1 1, Cmd.none )



-- UPDATE


dieRoll : Random.Generator Int
dieRoll =
    Random.int 1 6


rollTwoDice : Random.Generator ( Int, Int )
rollTwoDice =
    Random.pair dieRoll dieRoll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFaces rollTwoDice )

        NewFaces ( newFace1, newFace2 ) ->
            ( Model newFace1 newFace2, Cmd.none )



-- SUBS


subs : model -> Sub msg
subs model =
    Sub.none



-- VIEW


type Msg
    = Roll
    | NewFaces ( Int, Int )


dieFaceIcon : Int -> String
dieFaceIcon dieResult =
    dieResult
        + 9855
        |> Char.fromCode
        |> String.fromChar


twoDieFacesText : Model -> Html Msg
twoDieFacesText model =
    dieFaceIcon model.dieFaceOne
        ++ dieFaceIcon model.dieFaceTwo
        |> text


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ twoDieFacesText model ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]
