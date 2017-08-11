module Mail exposing (..)

import Html.Attributes exposing (id, class, value, type_)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)
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
  , forward : String
  , inbox : String
  , newMessages : String
  , users : List User
  , inboxMessages : List InboxMessage
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
  , forward = ""
  , inbox = ""
  , newMessages = ""
  , users = [ user1, user2, user3, user4, user5, user6 ]
  , inboxMessages = [inboxMessage1, inboxMessage2, inboxMessages3, inboxMessages4, inboxMessages5, inboxMessages6]
  }

type alias InboxMessage =
  { id : Int
  , fromUserId : Int
  , toUserId : Int
  , subject : String
  , messageBody : String
  }

inboxMessage1: InboxMessage
inboxMessage1 =
  { id = 1
  , fromUserId = 1
  , toUserId = 2
  , subject = "Hello"
  , messageBody = "Hi, How are you doing?"
  }

inboxMessage2 =
  { id = 2
  , fromUserId = 2
  , toUserId = 1
  , subject = "Hello"
  , messageBody = "Hi, I am doing great."
  }

inboxMessages3 =
  { id = 3
  , fromUserId = 3
  , toUserId = 4
  , subject = "Hello"
  , messageBody = "Hi, are you ok"
  }

inboxMessages4 =
  { id = 4
  , fromUserId = 4
  , toUserId = 3
  , subject = "Hello"
  , messageBody = "Hi, I am ok and you?"
  }

inboxMessages5 =
  { id = 5
  , fromUserId = 5
  , toUserId = 4
  , subject = "Hi"
  , messageBody = "hi, How is life"
  }

inboxMessages6 =
  { id = 6
  , fromUserId =5
  , toUserId = 6
  , subject = "Good day"
  , messageBody = "Hi, Life is great and there?"
  }




init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)



-- Update
 
type Msg
    = Username String
    | Password String
    | Login
    | Logout
    | Message String
    | Reply String
    | Filter String
    | Send  String
    | Delete Int
    | Forward String
    | Inbox String
    | NewMessage InboxMessage



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
  , password = "1992"
  }

user5 : User
user5 =
  { username = "user5"
  , password = "2014"
  }
    
user6 : User
user6 =
 { username = "user6"
 , password = "2008"
 }


update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    Username username ->
      ({ model | username = username }, Cmd.none )

    Password password ->
      ({ model | password = password }, Cmd.none )
    
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
              "Invalid username or password"

        validate user =
          (user.username == model.username && user.password == model.password)

      in
        ({ model | message = validationMessage }, Cmd.none )

    Logout ->
      (model, Cmd.none)

    Message message ->
      (model, Cmd.none)

    Reply fromUserId ->
      (model, Cmd.none)

    Filter filter ->
      (model, Cmd.none)

    Send send ->
      (model, Cmd.none)

    Delete messageId ->
      let
        inboxMessages =
            model.inboxMessages

        pred message =
          message.id /= message.id

        updatedInboxMsg =
          List.filter pred inboxMessages
      in
        ({ model | inboxMessages = updatedInboxMsg }, Cmd.none )

    Forward forward ->
      (model, Cmd.none )
      

    Inbox inbox ->
      (model, Cmd.none)

    NewMessage inboxMessage ->
      (model, Cmd.none)
  
messagePage : Model -> Html Msg
messagePage model =
    div [ id "message" ]
        [ h1 [] [ text "Message" ]
        , text model.message
        , textarea [] [ text "" ]
        , button  [ onClick ( Reply "delivered") ] [ text "reply"]
        , button  [ onClick ( Send "sent")] [ text "send"]
        ]

inboxPage : Model -> Html Msg
inboxPage model =
  let
    inboxMessages = model.inboxMessages
  in
    div [ id "inbox" ]
        [ h1 [] [ text "Inbox"]
        , ul []
             (List.map addInboxMessage inboxMessages)
        ]

addInboxMessage inboxMessage =
  li [] [ text inboxMessage.messageBody
        , button [onClick ( Delete inboxMessage.id), value "Delete" ] [ text "delete"]
        , button [onClick ( Reply "reply"), value "Reply" ] [ text "reply"]
        , button [onClick ( Forward ""), value "Forward" ] [ text "forward"]
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
               , type_ "texStringt"
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
       ]

sendView : Model -> Html Msg
sendView model =
  div [ id "send" ]
      [ h1 [] [text "send"]
      , label []
              [ text "fromUserId" ]
      , input [ id "fromUserId-field"
              , type_ "text"
              , value "send"
              ]
              []
      , button [ onClick (Send "") ] [ text "Send"]
      , button [ onClick (Delete 0)] [ text "Delete"]
      , button [ onClick (Reply "")] [ text "Reply"]
      , button [ onClick (Forward "")] [ text "Forward"]
      ]

view : Model -> Html Msg
view model =
  case model.message == "Ok" of
    True ->
      inboxPage model
    False ->
      loginPage model
  

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none