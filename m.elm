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
    ( model, Cmd.none )


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
    [ Badge.pill [] [ text "Default" ]
    , Badge.pillPrimary [ class "ml-1" ] [ text "Primary" ]
    , Badge.pillSuccess [ class "ml-1" ] [ text "Success" ]
    , Badge.pillInfo [ class "ml-1" ] [ text "Info" ]
    , Badge.pillWarning [ class "ml-1" ] [ text "Warning" ]
    , Badge.pillDanger [ class "ml-1" ] [ text "Danger" ]
    ]

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none