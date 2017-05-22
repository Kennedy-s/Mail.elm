module Taxi exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http 


main =
  Html.program
      { init = init
      ,view = view 
      , update = update
      , subscriptions = subscriptions
      }

--Model 

type alias Model =
     { driverId : Int
     , carId : String
     , owner : String
     , passangerNumbers : Int
     }


model : Model
model = 
    { driverId = ""
    , carId = ""
    , owner = ""
    , passangerNumbers = ""
    }


init : ( Model, Cmd Msg)
init = 
  ( model, Cmd.none)



--Update 

type Msg
  = DriverId Int
  | CarId String
  | Owner String
  | PassangerNumbers Int
   

update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    DriverId driverId ->
     ({ model | driverId = driverId }, Cmd.none) 
 
    CarId carId ->
    ({ model | carId = carId }, Cmd.none)

    Owner owner ->
     ({ model | owner = owner }, Cmd.none)

    PassangerNumbers passangerNumbers ->
     ({ model | passangerNumbers = passangerNumbers }, Cmd.none)


--View


view : Model -> Html Msg
view model =
    div [ ]
        [ input [ type_ "text" ] [ text "driverId" ]
        , div [] [ text (toString model) ]
        , input [ type_ "text" ] [ text "carId" ]
        , div [] [ text (toString model) ]
        , input [ type_ "text" ] [ text "owner" ]
        , div [] [ text (toString model) ]
        , input [ type_ "text" ] [ text "passangerNumbers" ]
        , button [ onClick DriverId ] [ text "Submit" ] 
        ]



--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none