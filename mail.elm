module Main exposing (..)

import Html.Attributes exposing (id, class, value, type_)
import Html.Events exposing (..)
import Html exposing (..)
import Http 
import Json.Decode as Json

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- Model

type alias Model =
  { username : String
  , password : String
  , login : String
  , logout : String
  , message : String
  , reply : String
  , filter : String
  , send  : String
  , users : List User
  }

model : Model
model = 
  { username = ""
  , password = ""
  , login = ""
  , logout =  ""
  , message = ""
  , reply = ""
  , filter = ""
  , send = ""
  , users = [ user1, user2, user3, user4, kennedy, mks ]
  }

init : ( Model, Cmd Msg)
init = 
  ( model, Cmd.none)



-- Update
 
type Msg
    = Username  String
    | Password  String
    | Login  
    | Logout 
    | Message String
    | Reply String
    | Filter String
    | Send String


type alias User =
   { username : String 
   , password : String
   }



user1 : User
user1 = 
  { username = "user1"
  , password = "1234"
  }

user2 : User
user2 =
  { username = "user2"
  , password = "5678"
  }

user3 : User
user3 =
  { username = "user3"
  , password = "2468"
  }   

user4 : User
user4 = 
  { username = "user4"
  , password = "7890"
  }

kennedy : User
kennedy =
  { username = "kennedy"
  , password = "1991"
  }

mks : User
mks =
 { username = "mks"
 , password = "2010"
 }

update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    Username username ->
      ({ model | username = username }, Cmd.none)

    Password password ->
      ({ model | password = password }, Cmd.none)
    
    Login ->
      let 
        -- validation

        validationMessage = 
          List.filter validate model.users
            |> List.head
            |> justUser

        justUser maybeUser = 
          case maybeUser of 
            Just user ->
              "Ok"
            Nothing ->
              "Invalid username/password"

        validate user = 
          (user.username == model.username && user.password == model.password)

      in
        ({ model | message = validationMessage }, Cmd.none)

    Logout ->
      (model, Cmd.none)

    Message message ->
      

      ({ model | message = message }, Cmd.none)

    Reply reply -> 
      ({ model | reply = reply }, Cmd.none)

    Filter filter ->
      ({ model | filter = filter }, Cmd.none)

    Send send ->
      ({ model | send = send }, Cmd.none)

   InboxPage inboxpage 
     let 
        -- messages
           viewMessages =
         



      ({ model | messageView = messageView }, Cmd.none)
    

  
messagePage : Model -> Html Msg
messagePage model =
    div [ id "message" ]
        [ h1 [] [ text "Message" ]
        , text model.message
        , textarea [] [ text "type your message" ]
        , button  [ onClick ( Filter "filter"), value "Filter" ] [ text "filter"]
        , button  [ onClick ( Reply "delivered"), value "Reply" ] [ text "reply"]
        , button  [ onClick ( Send "sent"), value "Send" ] [ text "send"]
        ]
           
-- View

loginPage : Model -> Html Msg
loginPage model = 
  div  [ id "login-form" ] 
       [ h1 [] [ text "Login Form" ]
       , div [] [text model.message]
       , label []
               [ text "username" ]
       , input [ id "username-filed"
               , type_ "text"
               , value model.username 
               , on "input" (Json.map (\str -> Username str) targetValue)
               ] 
               []
       , label [] 
               [ text "password: " ]
       , input [ id "password-field"
               , type_ "password"
               , value model.password    
               , on "input" (Json.map (\str -> Password str) targetValue)          
               ]
               []
       , button [ onClick Login ] [ text "Login" ]
       , button [ onClick Logout ] [ text "Logout" ]
       ]

view : Model -> Html Msg
view model =
  case model.message == "Ok" of
    True ->
      messagePage model
    False ->
      loginPage model
    True
      inboxPage model



-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none