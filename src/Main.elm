module Main exposing (..)
import Browser
import Html.Events exposing (onClick)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import String

main = Browser.sandbox {init=init, update=update, view=view}

defaultProduct =
  { name = "Default"
  , price = 5.2
  , quantity = 3
  , color = gray500
  }

init = [
  { name = "Fraise"
  , price = 5.2
  , quantity = 3
  , color = red600
  },
  { name = "Cerise"
  , price = 6.0
  , quantity = 1
  , color = red800
  },
  { name = "Framboise"
  , price = 5.5
  , quantity = 2
  , color = pink600
  }
  ]

type alias Model = 
  List Product

type alias Product =
  { name : String
  , price : Float
  , quantity : Int
  , color : Element.Color
  }

type Msg productName =
  Increment productName
  | Decrement productName

update msg model =
  case msg of
    Increment productName ->
      let 
        updateQuantity product =
          if (product.name == productName) then
            { product | quantity = product.quantity + 1 }
          else
            product
        products = 
          List.map updateQuantity model
      in
        products

    Decrement productName ->
      let 
        updateQuantity product =
          if (product.name == productName && product.quantity >= 1) then
            { product | quantity = product.quantity - 1 }
          else
            product
        products = 
          List.map updateQuantity model
      in
        products

view model =
    Element.layout []
        --row_of_stuff
        (stock_items model)

row_of_stuff : Model -> Element (Msg String.String)
row_of_stuff model =
  let 
    isProductFraise product =
      if (product.name == "Fraise") then
        True
      else 
        False
    productFraise = Maybe.withDefault defaultProduct (List.head (List.filter isProductFraise model))
  in 
    row [ width fill, centerY, spacing 30 ]
        [ myElement
        , myElement
        , el [ alignRight ] myElement
        , (stock_item productFraise)
        , (stock_items model)
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

stock_items : Model -> Element (Msg String.String)
stock_items model =
  let 
    isProduct productName product =
      if (product.name == productName) then
        True
      else 
        False
    productFraise = Maybe.withDefault defaultProduct (List.head (List.filter (isProduct "Fraise") model))
    productCerise = Maybe.withDefault defaultProduct (List.head (List.filter (isProduct "Cerise") model))
    productFramboise = Maybe.withDefault defaultProduct (List.head (List.filter (isProduct "Framboise") model))
  in
    column [ centerX, spacing 30]
          [ stock_item productFraise
          , stock_item productCerise
          , stock_item productFramboise
          , count_display model
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
red600 = rgb255 220 38 38
red500 = rgb255 239 68 68
red800 = rgb255 153 27 27
pink600 = rgb255 219 39 119

stock_item : Product -> Element (Msg String.String)
stock_item product =
  row [ Background.color gray300
      , Border.rounded 10
      ]
    [ (stock_item_count product.quantity)
    , (stock_item_name product.name product.color)
    , (stock_item_minus_button product.name)
    , (stock_item_plus_button product.name)
    ]


stock_item_count quantity =
  el [ padding 20
     ]
  (text (String.fromInt quantity))


stock_item_name productName color =
  el [Background.color color
      , padding 20
      ]
  (text productName)


stock_item_minus_button productName =
  Input.button [ padding 20
               , mouseOver [ Background.color gray500 ]
               ]
              { label = text "-"
              , onPress = Just (Decrement productName)
              }

stock_item_plus_button productName =
  Input.button [ padding 20
               , Border.widthEach { left = 2, right = 0, top = 0, bottom = 0}
               , Border.color gray500
               , Border.roundEach { topRight = 10, bottomRight = 10, topLeft = 0, bottomLeft = 0}
               , mouseOver [ Background.color gray500 ]
               ]
              { onPress = Just (Increment productName)
              , label = text "+"
              }
count_display : Model -> Element msg
count_display model =
  let 
    getQuantity product =
      product.quantity
    quantities = List.map getQuantity model
    total_quantity = List.foldr (+) 0 quantities
  in
    el [ Background.color gray300]
     (text (String.fromInt total_quantity))


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