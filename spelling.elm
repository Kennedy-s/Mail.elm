port module Spelling exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String 
import Html exposing (..)

main =
     program
         { init = init
         , view = view
         , update = update
         , subscriptions = subscriptions
         }
 

--Model
  
type alias Model =
    { word : String 
    , suggestions : List String
    , check : String
    }

model : Model
model =
  { word = ""
  , suggestions = ""
  , check = ""
  }



init : ( Model, Cmd Msg)
init =
  ( Model "" [], Cmd.none)


  --Update 


type Msg 
    = Change String
    | Check String
    | Suggest (List String)
    | Suggestions String

    
update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    Change newWord ->0
      ( Model newWord [], Cmd.none )

    Check check->
      ( model, check model.word )

    Suggest newSuggestions ->
      ( Model model.word newSuggestions, Cmd.none )



--View 

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput Change ] []
    , button [ onClick Check ] [ text "Check"]
    , div [] [ text (String.join ", " model.suggestions) ]
    ] 


--Subscriptions 

port suggestions : (List String -> msg) -> Sub Msg

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none