module Players exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

--Model

type alias Model =
     { players : String
     }

model : Model
model =
   { players = ""
   }

init : Model
init model =
  ( model, Cmd.none)


--Update

type Msg
    = Msg.OnFetchPlayers String
    | WebData String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of 
    Msg.OnFetchPlayers str ->
        ({ model | players = str }, Cmd.none )

    WebData str ->
        ({ model | webData = str }, Cmd.none )

--View

view : Model -> Html Msg
view model =
    div []
        [ text ""]
            


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none