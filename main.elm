module Main2 exposing (..)


import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)
import Keyboard exposing (..)
import Json.Decode as Json


main =
 Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }


foo: String -> String -> Int -> String
foo str1 str2 num =
  str1 ++ str2 ++ toString(num)


--Model

type alias Model =
   { homePage : String
   , contactPage : String
   , aboutPage : String
   , servicePage : String
   , username : String
   , password : String
   , login : String
   , logout : String
   , users : List User
   , message : String
   }


model : Model
model =
   { homePage = ""
   , contactPage = ""
   , aboutPage = ""
   , servicePage = ""
   , username = ""
   , password = ""
   , login = ""
   , logout = ""
   , users = [ user1, user2, user3 ]
   , message = ""
   }



init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)



--Update

type Msg
    = HomePage String
    | ContactPage String
    | ServicePage String
    | AboutPage String
    | Username String
    | Password String
    | Login
    | Logout
    | Message String



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


update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    Username str ->
      ({ model | username = str }, Cmd.none)
    
    Password str ->
      ({ model | password = str }, Cmd.none)

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
    HomePage str ->
      ({ model | homePage = str }, Cmd.none)

    ContactPage str ->
      ({ model | contactPage = str }, Cmd.none)

    ServicePage str ->
      ({ model | servicePage = str }, Cmd.none)

    AboutPage  str->
      ({ model | aboutPage = str }, Cmd.none)

 
--View 

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
   div [myStyle2 ]
    [  div [ menuStyle]
           [ a[ href "http://www.miranetworks.net", myStyle ] [ text "Home" ]
           , a[ href "http://www.ibm.net", myStyle ] [ text " About" ]
           , a[ href "http://www.ilab.com", myStyle] [ text "Contact" ]
           , a[ href "http://www.vodacom.com", myStyle ] [ text "Service" ]
           ]

    , div [ footerStyle]
          [ h1 [] [ text ""]
          ]

    , text "Copyright@miranetworks.net"
    ]




myStyle =
  style
    [ ("padding", "10px")
    , ("margin", "10px")
    , ("backgroundColor", "blue")
    , ( "text-align", "right")
    , ("color", "#FF0000")
    , ("display", "fixed")
    , ("width", "100%")
    , ("border-radius", "50%")
    , ("boxSizing", "borderBox")
    ]


myStyle2 =
  style
    [ ("backgroundColor", "lightblue")
    , ("height", "100%")
    , ("float", "center")
    , ("padding", "10px")
    , ("margin", "0px")
    , ("border-radius", "")
    ]


menuStyle =
 style
    [ ("float", "right")
    , ("backgroundColor", "")
    , ("padding", "4px 0")
    , ("border-radius", "120%")
    , ("margin", "20px")
    ]


footerStyle =
 style
   [ ("padding", "10px")
   , ("margin", "10px")
   , ("float", "")
   , ("text-align", "justify")
   , ("background-color", "")
   , ("display", "fixed")
   ]



  

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none