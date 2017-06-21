module Email exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
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
  { email : String 
  , emailValidation : EmailsStatus
  , password : String
  , passwordValidation : PasswordStatus
  , confirmedPassword : String
  , passwordMatch : Bool
  , tos : Bool
  }

model : Model
model =
  { email = ""
  , emailValidation = ""
  , password = ""
  , passwordValidation = ""
  , confirmedPassword = ""
  , passwordMatch = ""
  , tos = ""
  }


type EmailsStatus
  = EmptyEmail
  | ValidEmail
  | InvalidEmail


type PasswordStatus
  = EmptyPassword
  | PasswordTooShort
  | PasswordTooLong
  | ValidPassword


init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)


--Update

type Msg
  = ChangeEmail String
  | ChangePassword String
  | ConfirmPassword String
  | ToogleTOs Bool


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of 
      ChangeEmail email ->
          { model | email = email }

      ChangePassword password ->
          { model | password = password }

      ConfirmPassword confirmed ->
          { model | confirmedPassword = confirmed }

      ToogleTOs bool ->
          { model | tos = bool }

validate model =
  let
      emailStatus =
          if model.email == "" then
              EmptyEmail
          else if String.contains "@" model.email then
              ValidEmail

          else 
              InvalidEmail
      passwordStatus =
          if String.length model.password < 8 then
              PasswordTooShort

          else if String.length model.password > 120 then
              PasswordTooLong

          else
              ValidPassword

      matching =
          model.password == model.confirmedPassword

      ready =
          (passwordStatus == ValidPassword)
              && (emailStatus == ValidEmail)
              && matching

  in
      { model 
          | emailValidation = emailStatus
          , passwordMatch = matching
          , ready = ready
      }


emailStatus = 
    let model.email == "" then
       EmptyEmail
    else if String.contant "@" model.email then
        ValidEmail

    else 
        Invalid

ChangeEmail email ->
     validate { model | email = email }


--View

view : Model -> Html Msg
view model =
    form []
        [ label []
            [ input [ onInput ChangeEmail ] []
            , text "email"
            , emailError model.emailValidation
            ]
        , label []
            [ input [ onInput ChangePassword ] []
            , text "password"
            , passwordError model.passwordValidation
            ]
        , label []
            [ input [ onInput ConfirmPassword ] []
            , text "confirm password"
            , matchingError model.matching
            ]
        , label []
            [ input [ type_ "checkBox", onClick ToogleTOS ] []
            , text "accept terms of service"
            , acceptError model
            ]
        , button [ type_ "submit" ] [ text "Sign up!" ]
        ]


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model=
  Sub.none