<!DOCTYPE HTML>
% from bottle import url
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>sidetracK</title>
        <link href="{{url('static',filename='style.css')}}" rel="stylesheet" type="text/css">
        <link href="{{url('static',filename='css/bootstrap.css')}}" rel="stylesheet" type="text/css">
        <meta name="viewport" content="initial-scale=1, width=device-width">
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
            <!---knapparna för de olika kategorierna, skickar med like,classified eller dislike i pythonfunktionen--->
                    <div class="categories">
                        <div class = "picposition">
                        %like = "like"
                        <a id = "picbull" href="/threadoverview/{{like}}/1">
                            <img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love">
                        </a>
                        %classified = "classified"
                        <a id = "picbull"href="/threadoverview/{{classified}}/1">
                            <img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified">
                        </a>
                        %dislike = "dislike"
                        <a id = "picbull"  href="/threadoverview/{{dislike}}/1">
                            <img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></a>
        </div>
                    </div>
            <!-- Rutor med Information om oss och regler för forumet -->
            <!--
            <div class="about_us">
                <h2>About us</h2>
                <p>Detta är ett projekt som är gjort av</p>
                <p>Max, Johannes, Per, Jacob och Simon</p>
            </div>
            -->
            <div class="rules">
                <h2>Rules</h2>
                    <ul id="ruleslist">
                        <li>Va trevlig</li>
                        <li>Vårda språket</li>
                        <li>Endast passande innehåll</li>
                        <li>SidetracKa hur mycket du vill</li>
                    </ul>
            </div>
            
            <footer>
                <p id="footer">sidetracK inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>