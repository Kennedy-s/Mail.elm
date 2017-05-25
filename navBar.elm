module NavBar exposing (..)

import Html exposing (..)
import Mouse 
import Keyboard 
import Http



main = 
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    } 

--Model

type alias Model =
     { mouseMsg : String
     , keyMsg : String 
     }


type alias KeyCode =
     Int


type alias Position =
    { x : Int
    , y : Int
    }

model : Model 
model =
  { mouseMsg = ""
  , keyMsg = ""
  }

init : (Model, Cmd Msg)
init = 
  ( model, Cmd.none )

-- Message

type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



--Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        MouseMsg position ->
            ({ model | mouseMsg = model.mouseMsg  }, Cmd.none )

        KeyMsg code ->
            ({ model | keyMsg = model.keyMsg  }, Cmd.none )


--View 

view : Model -> Html Msg
view model =
     div []
         []


 

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
