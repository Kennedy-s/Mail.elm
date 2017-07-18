module Message exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http exposing (..)



main =
   program
      { init = init
      , view = view
      , update = update
      , subscriptions = subscriptions
      }


--Module

type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( False, Cmd.none )


--Message

type Msg
    = Expand
    | Collapse
    | Message String
    | Send String
    | Reply String
    | Delete String



--Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
         Expand ->
             ( True, Cmd.none )

         Collapse ->
             ( False, Cmd.none )

         Message str ->
             (model, Cmd.none)
         
         Send str ->
          (model, Cmd.none)

         Reply str ->
          (model, Cmd.none)

         Delete str ->
          (model, Cmd.none)


--View

view : Model -> Html Msg
view model =
    if model then
       div []
           [ button [ onClick Collapse ] [ text "Collapse" ]
           , text "Siwadawada"
           ]

    else
       div []
           [ button [ onClick Expand ] [ text "Expand" ]
           , text "Mukhethwa Kennedy"
           ]
    

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none