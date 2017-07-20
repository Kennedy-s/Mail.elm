module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }

--Model

type alias Model =
    { email : String
    , emailValidation : EmailStatus
    , password : String
    , passwordValidation : PasswordStatus
    , confirmedPassword : String
    , passwordsMatch : Bool
    , tos : Bool
    , ready : Bool
    , showErrors : Bool
    }


model : Model
model =
    { email = ""
    , emailValidation = EmptyEmail
    , password = ""
    , passwordValidation = EmptyPassword
    , confirmedPassword = ""
    , passwordsMatch = True
    , tos = False
    , ready = False
    , showErrors = False
    }


init : ( Model, Cmd Msg)
init =
    ( model, Cmd.none)


type EmailStatus
    = EmptyEmail
    | ValidEmail
    | InvalidEmail


type PasswordStatus
    = EmptyPassword
    | PasswordTooShort
    | PasswordTooLong
    | ValidPassword


--Update

type Msg
    = ChangeEmail String
    | ChangePassword String
    | ConfirmPassword String
    | ToggleTOS Bool
    | Submit

update msg model =
    case msg of
        ChangeEmail email ->
            validate { model | email = email }

        ChangePassword password ->
            validate { model | password = password }

        ConfirmPassword confirmed ->
            validate { model | confirmedPassword = confirmed }

        ToggleTOS bool ->
            validate { model | tos = bool }

        Submit ->
            validate { model | showErrors = True }




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
            , passwordValidation = passwordStatus
            , passwordsMatch = matching
            , ready = ready
        }


--View

view model =
    Html.div []
        [ label [ style inputStyle ]
            [ text "email "
            , input [ type_ "text", onInput ChangeEmail ] []
            , if model.showErrors then
                emailError model.emailValidation
              else
                empty
            ]
        , label [ style inputStyle ]
            [ text "password "
            , input [ type_ "text", onInput ChangePassword ] []
            , if model.showErrors then
                passwordError model.passwordValidation
              else
                empty
            ]
        , label [ style inputStyle ]
            [ text "confirm password "
            , input [ type_ "text", onInput ConfirmPassword ] []
            , if model.showErrors then
                matchingError model.passwordsMatch
              else
                empty
            ]
        , label [ style inputStyle ]
            [ input [ type_ "checkbox", onCheck ToggleTOS ] []
            , text "accept terms of service"
            , if model.showErrors then
                acceptError model
              else
                empty
            ]
        , br [] []
        , button [ style buttonStyleReady, onClick Submit ]
            [ if not model.ready then
                text "Sign up!"
              else
                text "You signed up!"
            ]
        ]

emailError status =
    case status of
        ValidEmail ->
            div [ class "processing" ] [ text "looks good" ]

        InvalidEmail ->
            div [ style errorStyle ]
                [ text "that  doesn't look like an email" ]

        EmptyEmail ->
            div [ style errorStyle ]
                [ text "email is required" ]

passwordError status =
    case status of
        EmptyPassword ->
            div [ style errorStyle ]
                [ text "password is required" ]

        PasswordTooShort ->
            div [ style errorStyle ]
                [ text "password is too short" ]

        PasswordTooLong ->
            div [ style errorStyle ]
                [ text "password is too long" ]

        ValidPassword ->
            empty

matchingError matching =
    if not matching then
        div [ style errorStyle ] [ text "passwords don't match" ]
    else
        empty

acceptError model =
    if not model.tos then
        div [ style errorStyle ]
            [ text "accept the Terms of Service to sign up!" ]
    else
        empty

-- Some basic inline styles.

inputStyle =
    [ ( "display", "block")
    , ( "color", "#111")
    , ( "padding", "10px 10px")
    ]

errorStyle =
    [ ( "color", "red" ) ]


buttonStyleReady =
    [ ( "border-width", "10")
    , ( "border-radius", "5px")
    , ( "background-color", "blue")
    , ( "width", "20%")
    , ( "color", "white")
    , ( "padding", "9px 12px")
    ]


empty =
    text ""


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none