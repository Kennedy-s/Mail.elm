module RadioB exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onCheck)



main =
  Html.beginnerProgram 
  { model = chapter1
  , update = update
  , view = view
  }



-- MODEL


type alias Model =
  { fontSize : FontSize
  , content : String
  }


type FontSize
  = Small
  | Medium
  | Large
  | Extra


chapter1 : Model
chapter1 =
  Model Medium intro


intro : String
intro = ""


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
          "1.8em"

        Medium ->
          "2.2em"

        Large ->
          "2.6em"

        Extra ->
          "3.0em"
  in
    style [("font-size", size)]
