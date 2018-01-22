module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Random


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subs
        }



-- MODEL


type alias Model =
    { dieFace : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )



-- SUBS


subs : model -> Sub msg
subs model =
    Sub.none



-- VIEW


type Msg
    = Roll
    | NewFace Int


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieFace) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]
