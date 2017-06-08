module mk exposing (..)

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