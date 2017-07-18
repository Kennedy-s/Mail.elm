module M exposing (..)

import Html exposing ( Html, div, text, program)


main : Program Never Model Msg
main =
   program
       { init = init 
       , view = view 
       , update = update 
       , subscriptions = subscriptions 
       }

--Model 

type alias Model =
    String 

init : ( Model, Cmd Msg )
init = 
    ( "Hello my name is Mukhethwa Kennedy Siwadawada and am from Limpopo", Cmd.none )


--MESSAGE

type Msg
    = NoOp



--Update 

update : Msg -> Model -> ( Model, Cmd Msg)
update  msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

--View

view : Model -> Html Msg
view model =
    div []
        [ text model ]


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none