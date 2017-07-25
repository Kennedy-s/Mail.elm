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
     {  : String
     ,  : String
     ,  : String
     }

model : Model
model =
    {  = ""
    ,  = ""
    ,  = ""
    }

init : ( Model, Cmd Msg)
init =
  ( Model, Cmd.none )


--update

type Msg
    =  String
    |  String
    |  String
    |  
    

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of 
       str ->
        ({ model | taxis = str}, Cmd.none)

       str ->
        ({ model | carHire = str}, Cmd.none)

       str ->
        ({ model | shuttleCar = str}, Cmd.none)



 --View 

 view : Model -> Html Msg
 view model =
   div []
        [ text model "Cars" ]


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none 