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
        <script src="{{url('static',filename='static/jq/script.js')}}"></script>
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
        <div id="testruta">
            
            <form action="/savenewthread/{{threadcategori}}" enctype="multipart/form-data" method="post">
	        <h2 id="creathead">Title</h2>
	        <textarea id="threadtitle" name="title" onkeydown="return limitLines(this, event)" placeholder="Title" maxlength="50" rows="1" cols="50"></textarea>
	        <hr>
	        <h2>Text</h2>
	        <textarea id="threadtext" name="text" placeholder="Text (Optional)" maxlength="2000" rows="5" cols="50"></textarea>
	        <hr>
            <input id="jsaddfile" type="file" name="tspic" accept="image/*">
	        <input id="jsaddcomment" type="submit" value="Submit">
            </form>
            
            
        </div>


        </div>
        <footer id="footerindex">
                <p id="footinc">sidetracK inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
        </footer>
    </body>
</html>