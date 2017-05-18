module Players exposing (..)


import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http



main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

--Model

type alias Route route =
        { player : WebData List Player
        , route : route
        }


initialModel : Route -> Model
initialModel route =
       { players = RemoteData.Loading
       , route = route
       }

type alias WebData =
      String


type alias PlayerId =
      String



type alias Player =
       { id : PlayerId
       , name : String
       , level : Int
       }

type Msg 
     = OnFetchPlayers (WebData (List Player))
     | OnLocationChange Location 




--Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        Msg.OnFetchPlayers response ->
            ({ model | players = response }, Cmd.none )

--View

view : WebData (List Player) -> Html Msg
view response =
    div []
        [ nav 
        , maybeList response
        ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView


maybeList : WebData (List Player) -> Html Msg
maybeList response = 
  case response of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success players ->
      maybeListst players

    RemoteData.Failure error ->
      text (toString error)

--Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none