module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg(..), Post)
import State


rootView : Model -> Html Msg
rootView model =
    div [ id "app-root" ]
        [ main_ []
            [ div [ class "photo-list" ] <|
                List.map (viewPost model) model.posts
            ]
        , nav []
            [ div [ class "nav-inner" ]
                [ a [ href "./", class "nav-logo" ]
                    [ img [ src "./img/logo.svg" ] []
                    , text "Elmstagram"
                    ]
                ]
            ]
        , footer []
            [ div [ class "footer-inner" ]
                [ p []
                    [ a [ href "https://github.com/SekibOmazic/Elmstagram.git" ] [ text "View Source" ]
                    , text "|"
                    , a [ href "./" ] [ text "Elmstagram" ]
                    ]
                ]
            ]
        ]


viewPost : Model -> Post -> Html Msg
viewPost model post =
    figure [ class "photo-figure" ]
        [ div [ class "photo-wrap" ]
            [ a [ href "#" ]
                [ img [ src post.media, alt post.text, class "photo" ] []
                ]
            ]
        , figcaption []
            [ div [ class "caption-button" ]
                [ button [ class "like-button" ] [ text "♡" ]
                ]
            , div [ class "caption-content" ]
                [ div [ class "photo-stats" ]
                    [ strong [] [ text <| toString post.likes ]
                    , text " likes, "
                    , strong [] [ text <| toString post.comments ]
                    , text " comments"
                    ]
                , p [ class "photo-caption" ] [ text post.text ]
                ]
            ]
        ]
