module Mk exposing (..)

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
  { 

  }


model : Model
model =

init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)


--Update

type Msg 
    =
    |
    |


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of




--View 

view : Model -> Html Msg
vie model =
    div [ ]



--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model =
