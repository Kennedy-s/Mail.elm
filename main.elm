module Main2 exposing (..)


import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http exposing (..)
import Keyboard exposing (..)


main = 
 Html.program
  { init = init
  , view = view 
  , update = update
  , subscriptions = subscriptions
  }


--Model

type alias Model =
   
   { homePage : String 
   , contactPage : String
   , aboutPage : String
   , servicePage : String
   }


model : Model
model = 
   { homePage = ""
   , contactPage = ""
   , aboutPage = ""
   , servicePage = ""
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


update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
  case msg of
    HomePage str ->
      ({ model | homePage = str }, Cmd.none)

    ContactPage str ->
      ({ model | contactPage = str}, Cmd.none)

    ServicePage str ->
      ({ model | servicePage = str}, Cmd.none)

    AboutPage  str->    
      ({ model | aboutPage = str}, Cmd.none)

 
--View 

view : Model -> Html Msg
view model =
   div [myStyle2 ]
    [  div [ menuStyle] 
           [ a[ href "http://www.miranetworks.net", myStyle ] [ text "Home" ]
           , a[ href "http://www.sableassets.co.za", myStyle ] [ text " About" ]
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
    , ("backgroundColor", "")
    , ("text-align", "justify")
    , ("color", "#FF0000")
    , ("font-style", "italic")
    , ("border", "5px")
    , ("text-decoration", "")
    , ("position", "relative")
    , ("display", "")
    ]


myStyle2 =
  style
    [ ("backgroundColor", "lightblue")
    , ("height", "100%")
    , ("float", "center")
    , ("padding", "10px")
    , ("margin", "0px")
    ]


menuStyle = 
 style
    [ ("float", "right")
    , ("backgroundColor", "#FFF")
    , ("padding", "4px 0")
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