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
           <form id="about" action="MAILTO:sidetrack.inc@gmail.com" method="POST" enctype="text/plain">
			   
			   <h1>Contact us</h1>
			   <p>If you experience a bug or have any wishes or any kind of critique, dont hesitate to contact us through the form below!</p>
			   
			   <h2>Email:</h2>
			   
			   <input type="text" name="email" placeholder="Email" rows="1" cols="30" maxlength="30">
			   
			   <h2>Type in your feedback here</h2>
			   
			   <input type="text" name="text" placeholder="Title" rows="5" cols="50" maxlength="1500">
			   
			   <input type="submit" value="Send">
			   <input type="reset" value="Reset"
					  
			</form>
            
            <footer>
                <p id="footer">sidetracKz0r inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>