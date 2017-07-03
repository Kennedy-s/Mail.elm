module Mk exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)


main =
  program
     { init = init 
     , view = view 
     , update = update
     , subscriptions = subscriptions
     }


--Model 
 
type alias Model =
  { accceptError : String 
  , confirmedPassword : String
  , email : String
  , emailValidation : EmailStatus
  , matchError : String
  , match : String
  , password : String
  , passwordMatch : Bool
  , passwordTooLong : String
  , passwordTooShort : String
  , emailErro : String
  , passwordValidation : PasswordStatus
  , tool : Bool
  , invalid : String
  }

type EmailStatus
    = EmptyEmail
    | ValidMail
    | InvalidEmail

type PasswordStatus
    = EmptyPassword
    | PasswordTooShort
    | ValidPassword


model : Model
model =
   { accceptError = "" 
   , confirmedPassword = ""
   , email = ""
   , emailValidation = ""
   , matchError = ""
   , maatching = ""
   , password = ""
   , passwordMatch = ""
   , passwordTooShort = ""
   , emailErro = ""
   , passwordValidation = ""
   , tool = ""
   , invalid = ""
   }

init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)





--Update

type Msg
    = ChangeEmail String
    | ChangePassword String
    | ConfirmedPassword String
    | ToogleTOS Bool
    | AcceptErro String
    | Validate String
    | ValidEmail String
    | PasswrdTooLong String
    | EmailErro String
    | PasswordError String
    | MatchError String
    | Password String
    | Invalid String
    | Empty String





update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
      ChangeEmail email ->
          { model | email = email }

      ChangePassword password ->
          { model | password = password }

      ConfirmedPassword confirmed ->
          { model | confirmedPassword = confirmed }

      ToogleTOS str ->
         ( model, Cmd.none )


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
                    model.passwordTooShort
                else if String.length model.password > 120 then
                    PasswordTooLong

                else
                    ValidPassword

          matching =
              model.password == model.confirmedPassword

          ready =
                ( passwordStatus == ValidPassword )
                    && ( emailStatus == ValidEmail )
                    && matching
      
      in
                { model 
                    | emailValidation = emailStatus
                    , passwordValidation = passwordStatus
                    , passswordMatch = matching
                    , ready = ready
                }
emailStatus =
    if model.email == "" then
        EmptyEmail
    else if String.contains "" "@" model.email then
        ValidEmail
    else 
       Invalid

changeEmail email =
     Validate { model | email = email }


--View

view : Model -> Html Msg
view model =
    Html.form []
         [ label []
             [ input [ onInput ChangeEmail ] []
             , text "email error"
             , text model.emailValidation
             ]
         , label []
             [ input [ onInput ChangePassword ] []
             , text "password error"
             , text model.passwordValidation
             ]
         , label []
             [ input [ onInput ConfirmedPassword ] []
             , text "cofirm password"
             , text model.matching
             ]
         , label []
             [ input [ type_ "checkbox", onClick ToogleTOS ] []
             , text "accept terms of service"
             , text model.acceptError
             ]
         , button [ type_ "Sign Up" ] [ text "Sign up"]
         ]

emailErro status =
    case status of
        ValidEmail email ->
          empty

        InvalidEmail ->
          div [ class "error" ]
                [ text "that doesn't look like an email"]

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none