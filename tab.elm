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
    , state : String
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
    = Tab.Msg String
    | Tab.Link String
    | Tab.Pane String
    | Tab.View String
    | Tab.Items String
    | Tab.Item String
    | State String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
          TabMsg str ->
            ( { model | tabState = str }, Cmd.none )

          TabLink str ->
            ( { model | tabLink = str }, Cmd.none )

          TabPane str ->
            ( { model | tabPane = str }, Cmd.none )

          TabView str -> 
            ( { model | tabView = str }, Cmd.none )

          TabeItems str ->
            ( { model | tabItems = str }, Cmd.none )

          TabItem str -> 
            ( { model | tabItem = str }, Cmd.none )

          State str ->
            ( { model |state = str }, Cmd.none )
          

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
            ]
           Tab.view state.tabState

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none