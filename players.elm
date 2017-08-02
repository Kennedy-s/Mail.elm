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
     , playerSurname : String
     , playerId : Int
     }

model : Model
model =
    { playeName = ""
    , playerSurname = ""
    , playerId = ""
    }

init : ( Model, Cmd Msg)
init =
  ( Model, Cmd.none )


--update

type Msg
    = PlayerName String
    | PlayerSurname String
    | PlayerId String
      
    

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of 
      PlayerName str ->
        ({ model | playerName = str }, Cmd.none)

      PlayerSurname str ->
        ({ model | playerSurname = str }, Cmd.none)

      PlayerId str ->
        ({ model | playerId = str }, Cmd.none)

     
 --View 

 view : Model -> Html Msg
 view model =
   div []
       [ text "hello"
       , button [ onClick Submit ] [ text "Submit" ]
       , button [ onClick Cancel ] [ text "Cancel" ]
       ]


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none 