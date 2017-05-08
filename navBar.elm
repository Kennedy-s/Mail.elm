module NavBar exposing (..)


import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (..)
import Navigation
import Http


main = Program Never Model Msg
main =
  Html.program
      ( NewPage << ParsePage)
      { init = init << parsePage
      , view = view 
      , update = update
      , subcriptions = always Sub.none 
      }

--Model

type alias Project =
     { previewImageUrl : String
     , name : String
     , primaryUrl : String
     , description : String
     , repositoryurl : String
     }

type alias Model
     { project List Project : String
     , isLoading : Bool 
     , loadingFailed : Bool
     , page : Int
     , searchQuery : String
     }

(|:) : Decode.Decode (a -> b) -> Decode.Decode a -> Decode.Decode b 
(|:) =
    Decode.maps (<|)


decodeProject : Decode.Decoder Project
decodeProject =
    Decode.succeed Project
        |: (field "previewImageUrl" Decode.string)
        |: (field "name" Decode.string)
        |: (field "primaryUrl" Decode.string)
        |: (field "description" Decode.string)
        |: (field "repositoryurl" (Decode.maybe Decode.string))


--Update

type Msg
    = NoOp
    | NewPage Int
    | Next 
    | Prev 
    | LoadProjects (Result Http.Erro (List Project))
    | UpdateSearchQuery String


init : Int -> (Model, Cmd Msg)
init page =
    ( { Projects = []
    	, isLoading = True
    	, loadFailed = False
    	, page = page
    	, pageSize = 5 
    	, searchQuery = ""
      }
    , LoadProjects LoadProjects  
    )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
     case msg of 
     	   NoOp ->
     	        ( model, Cmd.none )

     	   LoadProjects (Ok Projects) ->
     	        ( { model
     	          | projects = projects
     	          , isLoading = False
     	          }
                  , Cmd.none
     	        )

     	   NewPage page ->
     	        ( { model
     	      	  | page = page
     	          } 
                  , notifyOffsetChanged
     	        )

     	   Next ->
     	       ( model, newPage <| model.page +1 ) 


     	   Prev ->
     	       ( model, newPage <| model.page -1 )

     	   UpdateSearchQuery query -> 
     	       ( { model 
     	         | searchQuery = query
     	     	 }
                 , Cmd.none
     	       )


--View 

view : Model -> Html Msg
view model =
     let 

        disablePrev ==
            model.page == 0
          
        disableNext =
            model.page *model.pageSize + model.pageSize >= List.length model.projects
     in
        div 
           [ class [ Container ]
           ]
           [ viewSidebar model
           , div 
               [ class [ Content ]
               ]
               [ Html.Keyed.node "div"
                   [ class [ ListContainer ] 
                   ]
                 <|
                   viewList model
               , div 
                   [ class [ Paging ]
                   ]
                 <|
                    viewList model
               , div 
                   [ class [ Paging ]
                   ]
                   [ viewPageButton Prev disablePrev "Newer"
                   , viewPageButton Next disableNext "Older"
                   ]



               ]
          ]

viewPageButton : Msg -> Bool -> String -> Html Msg
viewPageButton msg isDisabled label =
    let
        textColor =
            if isDisabled then
                "#e5e5e5"
            else
                "#5cb5cd"
    in
        button
            [ onClick msg
            , disabled isDisabled
            , class [ Button ]
            ]
            [ text label ]


viewList : Model -> List ( String, Html Msg )
viewList model =
    let
        filterCriteria project =
            String.contains (String.toLower model.searchQuery) (String.toLower project.name)
    in
        if model.isLoading then
            [ ( "", h2 [] [ text "Loading" ] ) ]
        else if model.loadFailed then
            [ ( "", h2 [] [ text "Unable to load projects" ] ) ]
        else
            model.projects
                |> List.filter filterCriteria
                |> List.drop (model.page * model.pageSize)
                |> List.take model.pageSize
                |> List.map (\p -> ( p.primaryUrl, viewProject p ))



viewOpenSourceLink : Project -> Html Msg
viewOpenSourceLink project =
    case project.repositoryUrl of
        Just url ->
            a
                [ href url
                , class [ Link ]
                ]
                [ img
                    [ src "assets/github.svg"
                    , class [ GithubLogo ]
                    ]
                    []
                ]

            Nothing ->
                span [] []



viewProject : Project -> Html Msg
viewProject project =
    div
        [ class [ Styles.Project ]
        ]
        [ div
            [ class [ ProjectHeader ]
            ]
            [ a
                [ href project.primaryUrl
                , class [ Link ]
                ]
                [ h2 []
                    [ text project.name ]
                ]
            , viewOpenSourceLink project
            ]
        , p [] [ text project.description ]
        , div
            [ class [ ProjectScreenshotShell ]
            ]
            [ img
                [ src project.previewImageUrl
                , class [ ProjectImage ]
                ]
                []
            ]
        ]

viewSidebar : Model -> Html Msg
viewSidebar model =
    div [ class [ Sidebar ] ]
        [ div [ class [ Sidebar ] ]
            [ div 
                [ class [ SidebarLogoContainer ]
                ]
                [ a [ href ""]
                    [ img [ src "assets/logo.svg", class [ Logo ] ] [] ]

                ]
            , h1 []
                [ a 
                    [ href ""
                    , class [ BuiltWithLink ]
                    ]
                    [ span 
                    	  [ class [ BuiltWithText ]
                    	  ]
                    	  [ text "builtwith" ]
                    , span [] [ text "elm" ]
                    ]
                ]
            ]
        , div [ class [ SearcchContainer ] ]
            [ input 
            	  [ type_ "text"
            	  	, placeholder "Search" 
            	  	, value model.searchQuery
            	  	, autofocus True
            	  	, onInput UpdateSearchQuery
            	  	, class [ SearchInput ]
            	    ]
            	    []
            ]

        , div [ class [ SubmitProject ] ]
            [ h3 
           	      [ class ["SubmitProjectHeader" ]
                  ]
                  [ text "Submit a project" ]
            , p []
                [ span [] [ text "Submit a pull request or post an issue to" ]
                , a [ href "https://github.com/elm-community/builtwithelm" ] [ text "Kennedy Siwadie" ]
                , span [] [ text " Please include my full names " ]
                , strong [] [ text "100px * 800px" ]
                , span [] [ text "." ]
                ]


{ class } =
    Html.CssHelpers.withNamespace builtWithElmspace



--Subscriptions 

subscriptions : Model -> Html Msg
subscriptions model
 Sub.none