module MKS exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)

main =
  Html.program
    { init = init 
    , view = view
    , update =update
    , subscriptions = subscriptions
    }


--Model 

type alias Model =
     { playeName : String
     , playerId : String

     }

model : Model
model =
    { playeName = ""
    , playerId = ""
 
    }

init : ( Model, Cmd Msg)
init =
  ( Model, Cmd.none )


--update

type Msg
    = PlayerName String
    | PlayerId String
      
    

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of 
      PlayerName str ->
        ({ model | playerName = str}, Cmd.none)

      PlayerId str ->
        ({ model | playerId = str}, Cmd.none)

     


 --View 

 view : Model -> Html Msg
 view model =
   div []
       [ ]
     


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none 