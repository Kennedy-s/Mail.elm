import Html exposing (Html, p, label, input, div, button)
import Html.Attributes exposing (checked)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
 
 
 
main =
   Html.program
     { init = init
     , view = view
     , update = update
     , subscriptions = subscriptions
     }
 
 
 
 -- MODEL
 
 
type alias Model = 
      { time : Time
      , paused : Bool
      , resumed : Bool
      , stop : Bool
      }
 
 
initialModel : Model
initialModel =
   { time = Time.second
   , paused = False
   , resumed = False
   , stop = False
   }
 
init : (Model, Cmd Msg)
init =
   (initialModel, Cmd.none)

 
 -- UPDATE
 
 
type Msg
   = Tick Time
   | Paused
   | Resumed
   | Stop

 
 
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
   case msg of
     Tick newTime ->
       if model.paused then
         (model, Cmd.none)
       else
         ({ model | time = newTime }, Cmd.none)
 
     Paused ->
       ({model | paused = True}, Cmd.none) 
 
     Resumed ->
       ({model | paused = False}, Cmd.none)

     Stop ->
       ({model | stop = False}, Cmd.none)


 
 
 

 -- VIEW
 
 
view : Model -> Html Msg
view model =
   let
     angle =
       turns (Time.inMinutes model.time)
 
     handX =
       toString (50 + 40 * cos angle)
 
     handY =
       toString (50 + 40 * sin angle)
   in
    div []
        [ svg [ viewBox "0 0 100 100", width "400px" ]
               [ circle [ cx "50", cy "50", r "45", fill "#650000" ] []
               , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke ".." ] []
               , line [ x1 "50", y1 "50", x2  handX, y2 handY, stroke ".." ] []
               , line [ x1 "50", y1 "50", x2  handX, y2 handY, stroke "blue", strokeWidth "1" ] []
               ]
        , button [ onClick Paused ]
                  [ text "Pause"]

         , button [ onClick Resumed]
                 [ text "Resume"]

         , button [ onClick Stop ]
                  [ text "Stop"]
          ]



 -- SUBSCRIPTIONS
 
subscriptions : Model -> Sub Msg
subscriptions model =
   Time.every second Tick