module RadioB exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onCheck)



main =
  Html.program 
   { init = init
   , update = update
   , view = view
   , subscriptions = subscriptions
   }



-- MODEL


type alias Model =
  { fontSize : FontSize
  , content : String
  }


model : Model
model =
  { fontSize = ""
  , content = ""
  }

init : (Model, Cmd Msg)
init =
  ( model, Cmd.none )

type FontSize
  = Small
  | Medium
  | Large 
  | Extra 


chapter1 : Model
chapter1 =
  Model Medium intro


intro : String
intro = """

# Kennedy Siwadawada

## Chapter 1

Happy families are all alike; every unhappy family is unhappy in its own way.

Everything was in confusion in the Oblonskys’ house. The wife had discovered
that the husband was carrying on an intrigue with a French girl, who had been
a governess in their family, and she had announced to her husband that she
could not go on living in the same house with him...

"""



-- UPDATE


type Msg
  = SwitchTo FontSize


update : Msg -> Model -> Model
update msg model =
  case msg of
    SwitchTo newFontSize ->
      { model | fontSize = newFontSize }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ fieldset []
        [ radio "Small" (SwitchTo Small)
        , radio "Medium" (SwitchTo Medium)
        , radio "Large" (SwitchTo Large)
        , radio "Extra " (SwitchTo Extra)
        ]
    ]


radio : String -> msg -> Html msg
radio value msg =
  label
    [ style [("padding", "20px")]
    ]
    [ input [ type_ "radio", name "font-size", onClick msg ] []
    , text value
    ]


sizeToStyle : FontSize -> Attribute msg
sizeToStyle fontSize =
  let
    size =
      case fontSize of
        Small ->
          "0.8em"

        Medium ->
          "1em"

        Large ->
          "1.2em"

        Extra ->
          "1.5em"
  in
    style [("font-size", size)]


--Subscriptions 

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none