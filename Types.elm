module Types exposing (..)

import Http exposing (..)


type alias Model =
    { posts : List Post
    }


type alias Post =
    { id : String
    , likes : Int
    , comments : Int
    , text : String
    , media : String
    }


initialModel : Model
initialModel =
    Model []


type Msg
    = FetchPosts (Result Http.Error (List Post))
    | IncrementLikes String
