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
     {

     }

model : Model
model =
    {

    }

init : ( Model, Cmd Msg)
init =
  ( Model, Cmd.none )


--update

type Msg
    =
    |
    |
    |

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of 



 --View 

 view : Model -> Html Msg
 view model =
    div []
    [ text "Hello"]


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none 