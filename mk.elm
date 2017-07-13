module Mk exposing (..)

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
  { homePage : String
  , contactPage : String
  , aboutPage : String
  }


model : Model
model =
    { homePage = ""
    , contactPage = ""
    , aboutPage = ""
    }

init : ( Model, Cmd Msg)
init =
  ( model, Cmd.none)


--Update

type Msg
    = HomePage String
    | ContactPage String
    | AboutPage String


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
      HomePage str ->
       ({ model | homePage = str }, Cmd.none)

      ContactPage str ->
       ({ model | contactPage = str}, Cmd.none)

      AboutPage  str->
        ({ model | aboutPage = str}, Cmd.none)


homeView : Model -> Html Msg
homeView model =
    div [ id "home" ]
        [ h1 [] [ text "home" ]
        , text "Home"
        ]

contactView : Model -> Html Msg
contactView model =
   div [ id "contact" ]
       [ h1 [] [ text "contact" ]
       , text "Contact"
       ]


aboutView : Model -> Html Msg
aboutView model =
    div [ id "about" ]
        [ h1 [] [ text "about" ]
        , text "About"
        ]




 
--View

view : Model -> Html Msg
view model =
   div [myStyle2 ]
    [  div [ menuStyle]
           [ a[ href "http://www.miranetworks.net", myStyle ] [ text "Home" ]
           , a[ href "http://www.ilab.com", myStyle ] [ text " Contact" ]
           , a[ href "http://www.sabledata.com", myStyle] [ text "About" ]
           ]
     , div [ footerStyle]
          [ h5 [] [ text ""]
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