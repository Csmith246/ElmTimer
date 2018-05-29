import Html exposing ( Html, div, text, beginnerProgram, button )
import Html.Attributes exposing ( style )
import Html.Events exposing ( onClick )
import Time exposing ( Time, second )

main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

-- Models

type alias Model = 
  { time : Time
  , ticking : Bool  
  }

init : (Model, Cmd Msg)
init =
  (Model 0 False, Cmd.none)


-- Update

timeIncrement : Time
timeIncrement = Time.second

type Msg = Tick Time
         | Start
         | Stop
         | Reset

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of 
    Tick newTime ->
      ( Model (timeIncrement + model.time) True, Cmd.none )
    Start ->
      ( Model model.time True, Cmd.none )
    Stop ->
      ( Model model.time False, Cmd.none )
    Reset ->
      ( Model 0 False, Cmd.none )


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model = 
  if model.ticking == True then
    Time.every timeIncrement Tick
  else
    Sub.none


-- View

view : Model -> Html Msg
view model =
  div [ centeredLayout ] 
    [ text (formatTime (Time.inSeconds model.time)) 
    ,  div [] 
      [ button [ onClick Start ] [ text "Start" ]
      , button [ onClick Stop ] [ text "Stop" ]
      , button [ onClick Reset ] [ text "Reset" ]
      ]

    ]


formatTime : Time -> String
formatTime secs =
  toString (floor (secs/60)) ++ 
  ":" ++ 
  String.padLeft 2 '0' ( toString ((Result.withDefault 0 (String.toInt(toString(secs)))) % 60) ) 


-- Styles

centeredLayout : Html.Attribute msg
centeredLayout = 
  style
    [ ("display", "flex")
    , ("flex-direction", "column")
    , ("justifyContent", "center")
    , ("alignItems", "center")
    , ("height", "100%")
    ]





