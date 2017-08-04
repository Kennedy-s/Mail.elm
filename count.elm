module Player exposing (..)

import Html exposing (Html, div, text, program)
import Mouse 
import Keyboard 


-- Main

main =
   Html.program
         { init = init
         , view = view
         , update = update
         , subscriptions = subscriptions
         }

-- Model 

type alias Model =
     Int


init : ( Model, Cmd Msg )
init =
    ( 1, Cmd.none )


-- Message 

type Msg
    = MouseMsg Mouse.Position 
    | KeyMsg Keyboard.KeyCode



--Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        MouseMsg position ->
            ( model +2, Cmd.none )

        KeyMsg code -> 
            ( model +4, Cmd.none )


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
     