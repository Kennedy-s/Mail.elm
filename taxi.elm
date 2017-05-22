module Taxi exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
   }

model : Model
model =
  { atRankCount = 0
  , leftRankCount = 0
  }


init : ( Model, Cmd Msg)
init = 
  ( model, Cmd.none)


--Update

  --  Msg  - a.k.a action

type Msg 
    = Arrival 
    | Departure
    | Greet String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Arrival ->
      ({ model | atRankCount = model.atRankCount + 1}, Cmd.none)

    Departure ->
     ({ model | leftRankCount = model.leftRankCount - 1}, Cmd.none)

    Greet str ->
     let
        _ = Debug.log "debug" str
     in
        (model, Cmd.none)

-- View
view : Model -> Html Msg
view model =
  div []
  [ span [] [ text ("Number of taxi at the rank" ++ (toString model.atRankCount)) ] 
  , span [] [ text ("Number of taxi out of the rank" ++ (toString model.leftRankCount)) ]
  , input [ onClick Arrival ][ text "clock in"]
  , input [ onClick Departure ][ text "clock out"]
  , input [ onClick (Greet "hello") ][ text "Greet the taxi rank chairman."]
  ]

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none