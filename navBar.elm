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

update : Msg -> Model -> ( Number, Cmd Msg )
update msg model =
    case msg of 
        MouseMsg position ->
            ( model +1, Cmd.none )

        KeyMsg code ->
            ( model +2, Cmd.none )


--View 

view : Model -> Html Msg
view model =
     div []
         [ text (toString model) ]


 

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]
