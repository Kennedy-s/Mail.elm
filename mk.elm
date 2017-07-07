module Mk exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Http exposing (..)


main =
  Html.program
      { init = init
      , view = view
      , update = update
      , subscriptions = subscriptions
      }


--Model

type alias Model =
   { name : String
   , password : String
   , passwordAgain : String
   }


model : Model
model =
   { name = ""
   , password = ""
   , passwordAgain = ""
   }

init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)
    


--Update

type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update action model =
  case action of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }


--View

view : Model -> Html Msg
view address model =
  let
    validationMessage =
      if model.password == model.passwordAgain then
        span [style [("color", "green")]] [text "Passwords Match!"]
      else
        span [style [("color", "red")]] [text "Passwords do not match :("]
  in
    div []
      [ field "text" address Name "User Name" model.name
      , field "password" address Password "Password" model.password
      , field "password" address PasswordAgain "Re-enter Password" model.passwordAgain
      , div [fieldNameStyle "300px"] [validationMessage]
      ]


field : String -> Model -> (String -> Model) -> String -> String -> Html Msg
field fieldType address toAction name content =
  div []
    [ div [fieldNameStyle "160px"] [text name]
    , input
        [ fieldType
        , placeholder name
        , value content
        , on "input" targetValue (\string -> Signal.message address (toAction string))
        ]
        []
    ]


fieldNameStyle px =
  style
    [ ("width", px)
    , ("padding", "10px")
    , ("text-align", "right")
    , ("display", "inline-block")
    ]


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none