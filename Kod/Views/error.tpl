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
                        <li role="presentation"><a class="nav-text" id="feedback" href="/feedback">Feedback</a>
                        </li>
                        <li role="presentation"><a class="nav-text" href="/about">About us</a>
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
                %if errorvar == "Thank you for your feedback!":
                
                %else:
                <h1 id="errorhead">Ooops!</h1>
                %end
                %if errorvar == "Thank you for your feedback!":
                <h1 class="feedbackthanks">{{errorvar}}</h1>
                %else:
                <h2>{{errorvar}}</h2>
                <script src="{{url('static',filename='static/jq/script.js')}}"></script>
                %if errorvar == "Thank you for your feedback!":
                    
                %else:
                <button onclick="goBack()">Go Back</button>
                %end
            </div>
            
            <footer>
                <p id="footer">sidetracKz0r inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>