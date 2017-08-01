module Tab exposing (..)

import Html.Attributes exposing (..)
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
    { tabState : String
    , tabLink : String
    , tabPane : String
    , tabView : String
    , tabItems : String
    , tabItem : String
    }

model : Model
model =
    { tabState = ""
    , tabLink = ""
    , tabPane = ""
    , tabView = ""
    , tabItems = ""
    , tabItem = ""
    , state = ""
    }


init : ( Model, Cmd Msg )
init = 
    ( { tabState = Tab.initialState}, Cmd.none )

--Update 

type Msg
    = TabMsg String
    | TabLink String
    | TabPane String
    | TabView String
    | TabItems String
    | TabItem String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
          TabMsg state ->
            ( { model | tabState = state }
            , Cmd.none
            )

--View 

view : Model -> Html msg
view model = 
    Tab.config TabMsg
           Tab.items
            [ Tab.item 
                { id = "tabItem1"
                , link = Tab.link [] [ text "Tab 1" ]
                , pane =
                    Tabe.pane [ class "mt-3" ]
                         [ h4 [] [ text "Tab 1 Heading" ]
                         , p [] [ text "Contents of tab 1" ]
                         ]
                }
            , Tab.item
                { id = "tabItems2"
                , link = Tab.link [] [ text "Tab 2 " ]
                , pane = 
                    Tab.pane [ class "mt-3" ]
                        [ h4 [] [ text "Tab 2 Heading" ]
                        , p [] [ text "This is somethibg completely different" ]
                        ]       
                }
            , Tab.view state.tabState
            ]

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none