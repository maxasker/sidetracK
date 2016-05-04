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
                            <div class="catdiv"><img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love">
                        </div></a>
                        %classified = "classified"
                        <a href="/threadoverview/{{classified}}/1">
                            <div class="catdiv"><img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified">
                        </div></a>
                        %dislike = "dislike"
                        <a href="/threadoverview/{{dislike}}/1">
                            <div class="catdiv"><img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></div></a>
                            </div>
            
            <div id="about">
				<h1 id="abouthead">About us</h1>
				
				<p>Here at sidetracK we are all about freedom of speech! If you ever have a train of thought that you are to uncomfortable saying out loud you can post it here at sidetracK. Feeling happy? Come over the "Like" page and share your thoughts! If you are pissed off you can go ventilate your anger at the "Dislike" page and if you have done some thing really wacked we would love to hear all about it at the "Classified" page.</p>
				
				<p>Our mission is to create a site where you are completely anonymous and where you can share all your crazy thoughts and experiences with others! The site is supposed to start debates, make people laugh or engage in wild discussions and just let you say whatever comes to mind!</p>
				
				<p>If you are the kind of person that gets offended by everyone and everything, you came to the wrong place!</p>
			</div>
            
            <footer>
                <p id="footer">sidetracKz0r inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>