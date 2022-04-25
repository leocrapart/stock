module Main exposing (..)
import Browser
import Html.Events exposing (onClick)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import String


main = Browser.sandbox {init=0, update=update, view=view}

type Msg = 
  Increment 
  | Decrement

update msg model =
  case msg of 
    Increment ->
      model + 1

    Decrement ->
      model - 1

view model = 
    Element.layout []
        --row_of_stuff
        stock_items

row_of_stuff =
    row [ width fill, centerY, spacing 30 ]
        [ myElement
        , myElement
        , el [ alignRight ] myElement
        , stock_item
        , stock_items
        ]


myElement : Element msg
myElement =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Border.rounded 3
        , padding 30
        ]
        (text "stylish!")

stock_items =
  column [ centerX, spacing 30]
        [ stock_item 
        , stock_item
        , stock_item
        , count_display 2
        ]


-- stock_item = count + name + minus_button + plus_button
-- padding 30 

-- count = 

-- name =
-- paddingX 20

gray300 = rgb255 209 213 219
gray500 = rgb255 107 114 128
green600 = rgb255 22 163 74 
indigo600 = rgb255 79 70 229

stock_item =
  row [ Background.color gray300
      , Border.rounded 10
      ]
    [ stock_item_count
    , stock_item_name
    , stock_item_minus_button
    , stock_item_plus_button
    ]


stock_item_count = 
  el [ padding 20
     ]
      (text "2")


stock_item_name =
  el [Background.color green600
      , padding 20
      ]
  (text "kiwi")


stock_item_minus_button =
  Input.button [ padding 20
               , mouseOver [ Background.color gray500 ]
               ]
              { label = text "-"
              , onPress = Just Increment
              }

stock_item_plus_button =
  Input.button [ padding 20
               , Border.widthEach { left = 2, right = 0, top = 0, bottom = 0}
               , Border.color gray500
               , Border.roundEach { topRight = 10, bottomRight = 10, topLeft = 0, bottomLeft = 0}
               , mouseOver [ Background.color gray500 ]
               ]
              { onPress = Just Increment
              , label = text "+"
              }
count_display : Int -> Element msg
count_display count =
  el [ Background.color gray300]
    (text (String.fromInt count))


-- hover change color
-- hover change mouse click appearance

--v round the stock_item, not children one by one
--no default blue border onClick of default
-- feedback = ?

-- create model {} []
-- inject params

-- hex to color
-- "#D1D5DB" -> rgb 209 213 219


-- tailwindcss palette