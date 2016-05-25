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
            <!--Navigationsbar om oss och feedback. Lite bootstrap använt i designen-->
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
            <!--Våra tre huvudkategorier-->
            <!--knapparna för de olika kategorierna, skickar med like,classified eller dislike i pythonfunktionen-->
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
                        <a class="picbull" href="/threadoverview/{{dislike}}/1">
                            <img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></a>
        </div>
                    </div>
            <!-- Rutor med Information om oss och regler för forumet -->
            
            <div class="rules">
                <h2>Rules</h2>
                    <ul id="ruleslist">
                        <li>Be nice</li>
                        <li>Watch your language</li>
                        <li>Only appropriate content</li>
                        <li>SidetracK as much as you like</li>
                    </ul>
            </div>
            
        </div>
        <footer class="footerindex1">
                <p id="footinc">sidetracK inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
        </footer>
    </body>
</html>