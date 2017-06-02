module Main2 exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Html exposing (..)


main =
  Html.program
   { init = init
   , view = view
   , update = update
   , subscriptions = subscriptions
   }


--Model 

type alias Model
    { players : List Player
    }

initialModel : Model
initialModel =
    { players = [ Player "1" "Kennedy" 1]
    }

type alias PlayerId =
    String


type alias Player =
    { id : playerId
    , name : String
    , level : Int
    }


--Update 

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.NoOp ->
           ( model, Cmd.none )



--View

view : Model -> Html Msg
view model =
     div []
         [ page model ]

page : Model -> Html Msg
page model =
    players.List.view model.players    


--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model=
  Sub.none      