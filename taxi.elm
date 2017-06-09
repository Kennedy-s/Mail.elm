module Taxi exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html exposing (..)
import Http


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias TaxiId = Int


-- Model

type alias Model =
   { atRankCount : Int
   , leftRankCount : Int
   , greet : String
   }

model : Model
model =
  { atRankCount = 0
  , leftRankCount = 0
  , greet = "hi"
  }


init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)


--Update

  --  Msg  - action


type Msg
    = Arrival
    | Departure
    | Greet String
    | Submit


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Arrival ->
      ({ model | atRankCount = model.atRankCount +1}, Cmd.none)

    Departure ->
     ({ model | leftRankCount = model.leftRankCount - 1}, Cmd.none)

    Greet str ->
     let
        _ = Debug.log "debug" str
     in
        (model, Cmd.none)

    Submit ->
      (model, Cmd.none)

-- View

view : Model -> Html Msg
view model =
  div []
  [ span [] [ text ("Number of taxis at the rank" ++ (toString model.atRankCount)) ]
  , button [ onClick Arrival ][ text "clock in"]
  , div [] [ ]
  , span [] [ text ("Number of taxis out of the rank" ++ (toString model.leftRankCount)) ]
  , button [ onClick Departure ][ text "clock out"]
  , div [] [ ]
  , input [ onClick (Greet "hello") ][ text "Greet the taxi rank chairman."]
  , button [ onClick Submit ] [ text "Submit" ] 
  ]

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none