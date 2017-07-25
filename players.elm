module Players exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)


main =
   Html.rogram
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

--Model

type  alias Model =
     { players : List Player
     }

init : Model
init model =
    { players = [ Player "1" "Kennedy" 1 ]
    }


type alias PlayerId =
    String



type alias Player =
        { id : PlayerId
        , name : String
        , level : Int
        }


--Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of 
    Msg.OnFetchPlayers response ->
        ({ model | players = response }, Cmd.none )

--View

view : WebData (List Player) -> Html Msg
view response =
   div []
       [ nav 
       , maybeList response
       ]


maybeList : WebData (List Player) -> Html Msg
maybeList response = 
  case response of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success players ->
      maybeLists players

    RemoteData.Failure error ->
      text (toString error)

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none