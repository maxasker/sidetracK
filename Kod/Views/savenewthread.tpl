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
        <div id="testruta">
            <h1>
                Här är testrutan
            </h1>
            <form action="/savenewthread/{{threadcategori}}" enctype="multipart/form-data" method="post">
	        <h1>Rubrik</h1>
	        <textarea name="title" placeholder="Title" maxlength="100" rows="5" cols="50">Title</textarea>
	        <hr>
	        <h1>Brödtext</h1>
	        <textarea name="text" placeholder="Text" maxlength="2000" rows="5" cols="50">Text</textarea>
	        <hr>
            <input type="file" name="tspic" accept="image/*">
	        <input type="submit" value="Spara innehåll">
            </form>
            
            
        </div>

        
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>