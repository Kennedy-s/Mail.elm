module Page exposing (..)

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
    {  : String
    ,  : String 
    ,  : Int
    ,  : String
    }    


model : Model
model =
   {  = ""
   ,  = ""
   ,  = ""
   ,  = ""
   }
  

init : ( model, Cmd Msg )
init =
    ( model, Cmd.none )



--Update

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


--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none