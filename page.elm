module Page exposing (..)

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
    { home : String
    , contact : String
    , about : String
    , services : String
    }    


model : Model
model =
   { home = ""
   , contact = ""
   , about = ""
   , services = ""
   }
  


init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)


--Update

type Msg
    = Home String
    | Contact String
    | About String
    | Services String



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
     Home str ->
        ( model, Cmd.none )
     Contact str ->
        ( model, Cmd.none )

     About str ->
        ( model, Cmd.none )

     Services str ->
        ( model, Cmd.none )


homeView : Model -> Html Msg
homeView model =
    div [ id "home" ]
        [ h1 [] [text "home"]
        , text "Home"
        ]


aboutView : Model -> Html Msg
aboutView model =
    div [ id "about" ]
        [ h1 [] [text "about"]
        , text "About"
        ]

contactView : Model -> Html Msg
contactView model =
   div [ id "contact" ]
       [ h1 [] [text "contact"]
       , text "Contact"
       ]

serviceView : Model -> Html Msg
serviceView model =
   div [ id "services" ]
       [ h1 [] [text "services"]
       , text "services"
       ]




--View 

view : Model -> Html Msg
view model =
 div [myStyle2 ]
    [  div [ menuStyle]
           [ a[ href "http://www.miranetworks.net", myStyle ] [ text "Home" ]
           , a[ href "http://www.ilab.com", myStyle ] [ text " About" ]
           , a[ href "http://www.sabledata.com", myStyle] [ text "Contact" ]
           , a[ href "http://www.vodacom.com", myStyle ] [ text "Servicse" ]
           ]
    ]


myStyle =
  style
    [ ("padding", "10px")
    , ("margin", "10px")
    , ("backgroundColor", "blue")
    , ( "text-align", "right")
    , ("color", "#d90000")
    , ("display", "fixed")
    , ("width", "100%")
    , ("border-radius", "70%")
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
    , ("backgroundColor", "")
    , ("padding", "4px 0")
    , ("display", "fixed")
    ]


--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none