module Index exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http 


main =
  Html.program
  { init = init 
  , view = view
  , update = update
  , subscriptions = subscriptions
  }


-- Model
  
type alias Model = 

  { inboxPage : String
  , sentPage : String
  , draftPage : String
  , filterPage : String
  , messagePage : String
  , send : String
  , reply : String
  , filter : String
  , inbox : String
  , sent : String
  , draft : String
  , mailPage : String
  , message : String
  }

model : Model
model = 
  { inboxPage =  ""
  , sentPage = ""
  , draftPage = ""
  , filterPage = ""
  , mailPage = ""
  , reply = ""
  , send = ""
  , filter = ""
  , inbox = ""
  , sent = ""
  , draft = ""
  , messagePage = ""
  , message = ""
  } 

init : ( Model, Cmd Msg)
init = 
  ( model, Cmd.none)



-- Update 

type Msg
   = InboxPage String
   | SentPage String
   | DraftPage String
   | FilterPage String
   | MesssagePage String
   | Send String
   | Reply String
   | Filter String
   | Inbox String
   | Sent String
   | Draft String
   | MailPage String
   | Message String
   | Submit String



update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    InboxPage str ->
      ({ model | inboxPage = str }, Cmd.none)
    
    SentPage str ->
      ({ model | sentPage = str }, Cmd.none)

    DraftPage str ->
      ({ model | draftPage = str }, Cmd.none)

    FilterPage str ->    
      ({ model | filterPage = str }, Cmd.none)

    MailPage str ->
      ({ model | mailPage = str }, Cmd.none)

    Message str ->
      ({ model | message = str }, Cmd.none)

    Reply reply ->
      ({ model | reply = reply }, Cmd.none)

    MesssagePage str ->
      ({ model | messagePage = str }, Cmd.none)

    Send str ->
      ({ model | send = str }, Cmd.none)

    Draft str ->   
      ({ model | draft = str }, Cmd.none)

    Sent str ->
      ({ model | sent = str }, Cmd.none)
   
    Filter str ->
      ({ model | filter = str }, Cmd.none)
  
    Inbox str ->
      ({ model | inbox = str }, Cmd.none)



inboxView : Model -> Html Msg
inboxView model = 
    div [ id "inbox" ]
        [ h1 [] [ text "inbox" ]
        , text ""
        ]

sentView : Model -> Html Msg
sentView model = 
    div [ id "sent" ]
        [ h1 [] [ text "sent" ]
        , text ""
        ]

draftView : Model -> Html Msg
draftView model =
     div [ id "draft" ]
         [ h1 [] [ text "draft" ]
         , text ""
         ]


filterView : Model -> Html Msg
filterView model =
      div [ id "filter" ]
          [ h1 [] [ text "filter" ]
          , text ""
          ]

mailView : Model -> Html Msg
mailView model =
  div  [ id "mail" ] 
       [ h1 [] [ text "mailPage" ]
       , div [] [ text "" ]
       ]   


--View

view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text" ] [ text "mailPage" ]
    , input [ type_ "text" ] [ text "sentPage" ]
    , input [ type_ "text" ] [ text "filterpage" ]
    , button [ onClick Submit ] [ text "Submit" ]
    ]



--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model=
 Sub.none

