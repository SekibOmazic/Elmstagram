module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.Keyed
import Types exposing (..)
import State


rootView : Model -> Html Msg
rootView model =
    div [ id "app-root" ]
        [ main_ []
            [ viewPage model
            ]
        , nav []
            [ div [ class "nav-inner" ]
                [ a [ href (State.toUrl ListOfPosts), class "nav-logo" ]
                    [ img [ src "img/logo.svg" ] []
                    , text "Elmstagram"
                    ]
                ]
            ]
        , footer []
            [ div [ class "footer-inner" ]
                [ p []
                    [ a [ href "https://github.com/SekibOmazic/Elmstagram.git" ] [ text "View Source" ]
                    , text "|"
                    , a [ href (State.toUrl ListOfPosts) ] [ text "Elmstagram" ]
                    ]
                ]
            ]
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.page of
        ListOfPosts ->
            Html.Keyed.node "div"
                [ class "photo-list" ]
            <|
                List.map (viewKeyedPost model) model.posts

        SinglePost postId ->
            case getPost postId model.posts of
                Just post ->
                    div [ class "photo-single" ]
                        [ viewPost model post ]

                Nothing ->
                    div []
                        [ text ("Post " ++ postId ++ " not found!") ]


getPost : String -> List Post -> Maybe Post
getPost postId posts =
    let
        postsById =
            List.filter (\post -> post.id == postId) posts
    in
        List.head postsById


viewPost : Model -> Post -> Html Msg
viewPost model post =
    figure [ class "photo-figure" ]
        [ div [ class "photo-wrap" ]
            [ a [ href (State.toUrl <| SinglePost post.id) ]
                [ img [ src post.media, alt post.text, class "photo" ] []
                ]
            ]
        , figcaption []
            [ div [ class "caption-button" ]
                [ button [ onClick <| IncrementLikes post.id, class "like-button" ] [ text "♡" ]
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


viewKeyedPost : Model -> Post -> ( String, Html Msg )
viewKeyedPost model post =
    ( post.id
    , viewPost model post
    )
