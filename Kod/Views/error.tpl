<!DOCTYPE HTML>
% from bottle import url
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>sidetracK</title>
        <link href="{{url('static',filename='style.css')}}" rel="stylesheet" type="text/css">
        </..><link href="{{url('static',filename='css/bootstrap.css')}}" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="container">
                <!--Sidetrack logga--> 
                <div class="main-logotype">
                    <header>
                        <a class="main-logotype" href="/homepage">sidetracK</a>
                    </header>
                </div>
            <!-- Navigationsbar om oss och feedback. Lite bootstrap använt i designen -->
              <div class="top-bar">
                <nav>
                    <ul class="nav nav-pills">
                        <li role="presentation"><a class="nav-text" id="feedback" href="/threadoverview">Feedback</a>
                        </li>
                        <li role="presentation"><a class="nav-text" href="/createthread">Om oss</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <!-- Våra tre huvudkategorier -->
            <div class="categories">
                        %like = "like"
                        <a href="/threadoverview/{{like}}/1">
                            <div class="catdiv"><img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love"></li>
                        </a></div>
                        %classified = "classified"
                        <a href="/threadoverview/{{classified}}/1">
                            <div class="catdiv"><img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified">
                        </a></div>
                        %dislike = "dislike"
                        <a href="/threadoverview/{{dislike}}/1">
                            <div class="catdiv"><img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"</div></a>
            </div>
            
            
            <div id="errordiv">
<<<<<<< HEAD
                <h1>Ooops!</h1>
                <p>{{errorvar}}</p>
                <script src="{{url('static',filename='static/jq/script.js')}}"></script>
                <button onclick="goBack()">Go Back</button>
=======
                <h1 id="errorhead">Ooops!</h1>
                <h2>{{errorvar}}</h2>
                <h2>Go back to <a href="/homepage">sidetracK</a> and try again!</h2>
>>>>>>> origin/master
            </div>
            
            <footer>
                <p id="footer">sidetracKz0r inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>