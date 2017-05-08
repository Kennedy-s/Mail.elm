module Main2 exposing (..)


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
      let
         newPage =
          { frontPage = frontPage
          , backPage = backPage
          }

      in
       ({ model | homePage = newPage }, Cmd.none)

    ContactPage str ->
      let

      in
       ({ model | contactPage = str}, Cmd.none)

    ServicePage str ->
      let

      in
       ({ model | servicePage = str}, Cmd.none)

    AboutPage  str->
      let

      in
       ({ model | aboutPage = str}, Cmd.none)



homeView : Model -> Html Msg
homeView model = 
    div [ id "home" ]
        [ h1 [] [ text "home" ]
        , text ""
        ]


aboutView : Model -> Html Msg
aboutView model =
    div [ id "about" ]
        [ h1 [] [ text "about" ]
        , text "" 
        ] 

contactView : Model -> Html Msg
contactView model =
   div [ id "contact" ]
       [ h1 [] [ text "contact" ]
       , text ""
       ]

serviceView : Model -> Html Msg
serviceView model =
   div [ id "service" ]
       [ h1 [] [ text "service" ] 
       , text "service"
       , 
       ]

 
--View 

view : Model -> Html Msg
view model =
   div []
    [ input [ type_ "text" ] [ text "homePage" ]
    , input [ type_ "text" ] [ text "contactPage" ]
    , input [ type_ "text" ] [ text "aboutPage" ]
    , input [ type_ "text" ] [ text "servicePage" ]
    ]


 


--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
 Sub.none