module Mail exposing (..)

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
  , delete : String
  , inbox : String
  , newMessages : String
  , users : List User
  , inboxMessages : List InboxMessage 
  }


type alias InboxMessage = 
  { fromUserId : Int
  , toUserId : Int
  , subject : String
  , messageBody : String
  } 


inboxMessage1 = 
  { fromUserId = 1
  , toUserId = 2
  , subject = "Hello"
  , messageBody = "Hi, How are you doing?"
  } 

inboxMessage2 = 
  { fromUserId = 2
  , toUserId = 1
  , subject = "Hello"
  , messageBody = "Hi, I am doing great."
  } 

inboxMessages3 =
  { fromUserId = 3 
  , toUserId = 4
  , subject = "Hello"
  , messageBody = "Good day"
  }

inboxMessages4 =
  { fromUserId = 4
  , toUserId = 5
  , subject = "Hello"
  , messageBody = "How are you doing?"} 

inboxMessages5 =
  { fromUserId = 5
  , toUserId = 6
  , subject = "Hi"
  , messageBody = "how is life" 
  }

inboxMessages6 =
  { fromUserId =6
  , toUserId = 5
  , subject = "Gooda day"
  , messageBody = "Life is graet and you?"
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
  , delete = ""
  , inbox = ""
  , newMessages = ""
  , users = [ user1, user2, user3, user4, user5, user6 ]
  , inboxMessages = [inboxMessage1, inboxMessage2, inboxMessages3, inboxMessages4]
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
    | Delete String
    | Inbox String
    | NewMessages String


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

user5 : User
user5 =
  { username = "user5"
  , password = "1991"
  }

user6 : User
user6 =
 { username = "user6"
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
       let
        newInbox =
            { fromUserId = fromUserId
            , toUserId = toUserId
            , subject = subject
            , messageBody = messageBody
            } 
        
       in
        ({ model | inboxMessages = newMessages }, Cmd.none)

    Delete delete ->
          ({ model | delete = delete }, Cmd.none)

    Inbox inbox ->
      ({ model | inbox = inbox }, Cmd.none)

      
  
messagePage : Model -> Html Msg
messagePage model =
    div [ id "message" ]
        [ h1 [] [ text "Message" ]
        , text model.message
        , textarea [] [ text "type your message" ]
        , button  [ onClick ( Reply "delivered"), value "Reply" ] [ text "reply"]
        , button  [ onClick ( Send "sent"), value "Send" ] [ text "send"]
        ]

inboxPage : Model -> Html Msg
inboxPage model =
    div [ id "inbox" ]
        [ h1 [] [ text "Inbox"]
        , text model.inbox 
        , button [ onClick ( Filter "filter"), value "Filter" ] [ text "filter"]
        , button [ onClick ( Reply "reply"), value "Reply" ] [ text "reply"] 
        , button [ onClick ( Send "send"), value "Send" ] [ text "send"]
        , button [ onClick ( Delete "delete"), value "Delete" ] [ text "delete"]
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

send : Model -> Html Msg
send model =
  div [ id "send" ]
      [ h1 [ text "Sent" ]
      , label []
              [ text "fromUserId" ]
      , input [ id "fromUserId-field"
              , type_ "text"
              , value model.fromUserId
              ]
              []
      , button [ onClick Send ] [ text "Send"]
      , button [ onClick Delete ] [ text "Delete"]
      , button [ onClick Reply ] [ text "Reply"]
      ]

view : Model -> Html Msg
view model =
  case model.message == "Ok" of
    True ->
      messagePage model
    False ->
      loginPage model




-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none