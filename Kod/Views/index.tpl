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
                <div class="main-logotype">
                    <header>
                        <a class="main-logotype" href="/homepage">sidetracK</a>
                    </header>
                </div>
              <div class="top-bar">
                <nav>
                    <ul class="nav nav-pills">
                        <li role="presentation"><a class="nav-text" href="/threadoverview">threadoverview</a>
                        </li>
                        <li role="presentation"><a class="nav-text" href="/createthread">treatethread</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div id="categories">
                <ul>
                    %like = "like"
                    <a href="/threadoverview/{{like}}">
                        <li><img class="catpic" src="../static/like.png" alt="Picture of love"></li>
                    </a>
                    %classified = "classified"
                    <a href="/threadoverview/{{classified}}">
                        <li><img class="catpic" src="../static/classified.png" alt="Picture of classified"></li>
                    </a>
                    %dislike = "dislike"
                    <a href="/threadoverview/{{dislike}}">
                        <li><img class="catpic" src="../static/unlike.png" alt="Picture of dislike"</li>
                    </a>
                </ul>
            </div>
            <div class="about_us">
                <h2>About us</h2>
            </div>
            <div class="rules">
                <h2>Rules</h2>
            </div>
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>