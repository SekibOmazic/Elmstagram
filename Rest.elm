module Rest exposing (..)

import Json.Decode as Json exposing (..)
import Types exposing (Msg(..), Post)
import Http


decodePosts : Json.Decoder (List Post)
decodePosts =
    list <|
        map5 Post
            (field "id" string)
            (field "likes" int)
            (field "comments" int)
            (field "text" string)
            (field "media" string)


getPosts : Cmd Msg
getPosts =
    Http.send FetchPosts <|
        Http.get "data/posts.json" decodePosts
