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
     { taxis : String
     , carHire : String
     , shuttleCar : String
     }

model : Model
model =
    { taxis = ""
    , carHire = ""
    , shuttleCar = ""
    }

init : ( Model, Cmd Msg)
init =
  ( Model, Cmd.none )


--update

type Msg
    = Taxis String
    | CarHire String
    | ShuttleCar String
    

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of 
      Taxis str ->
        ({ model | taxis = str}, Cmd.none)

      CarHire str ->
        ({ model | carHire = str}, Cmd.none)

      ShuttleCar str ->
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