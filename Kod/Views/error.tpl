<!DOCTYPE HTML>
% from bottle import url
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>sidetracK</title>
        <link href="{{url('static',filename='style.css')}}" rel="stylesheet" type="text/css">
        <link href="{{url('static',filename='css/bootstrap.css')}}" rel="stylesheet" type="text/css">
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
                        <li role="presentation"><a class="nav-text" href="/feedback">Feedback</a>
                        </li>
                        <li role="presentation"><a class="nav-text" href="/about">About us</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <!-- Våra tre huvudkategorier -->
            <div class="categories">
                        <div class = "picposition">
                        %like = "like"
                        <a class="picbull" href="/threadoverview/{{like}}/1">
                            <img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love">
                        </a>
                        %classified = "classified"
                        <a class="picbull" href="/threadoverview/{{classified}}/1">
                            <img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified">
                        </a>
                        %dislike = "dislike"
                        <a class="picbull"  href="/threadoverview/{{dislike}}/1">
                            <img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></a>
        </div>
                    </div>
            
            
            <div id="errordiv">
                %if errorvar == "Thank you for your feedback!" or errorvar == "Thank you for the report, we will investigare this further!":
                
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
				%end
            </div>
        
        </div>
        <footer class="footerindex">
                <p id="footinc">sidetracK inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
        </footer>
    </body>
</html>