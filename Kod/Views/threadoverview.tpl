<!DOCTYPE HTML>
% from bottle import url
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>sidetracK</title>
        <link href="{{url('static',filename='style.css')}}" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="container">
                <div class="main-logotype">
                <header>
                    <a id="rubrik" href="/homepage">sidetracK</a>
                </header>
                </div>
             <div class="top-bar">
                <nav>
                    <ul class="nav nav-pills">
                        <li role="presentation" class="active"><a href="#">Home</a></li>
                        <li role="presentation"><a href="#">Profile</a></li>
                        <li role="presentation"><a href="/threadoverview">Messages</a></li>
                        <li role="presentation"><a href="/createthread">Kom till tråden</a></li>
                    </ul>
                </nav>
                 <div><a href="/{{threadcategori}}/createthread">Skapa tråd</a></div>
            </div>
                <div id="testruta">
            <div id="likebox">
                % for threadname in threads:
                %threadtextfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
                %threadtext = threadtextfile.read()
                %threadtextfile.close()
                <a href="/redirthread/{{threadcategori}}/{{threadname}}">Klicka här fitthue</a>
		        <h2>{{threadname.replace("_____", " ")}}</h2>
                <p>{{threadtext}}</p>
		        <hr>
		        % end
                </div>
            
                </div>
            <div class="btn-toolbar">
                <button type="button" class="btn btn-default">Left</button>
                <button type="button" class="btn btn-default">Middle</button>
                <button type="button" class="btn btn-default">Right</button>
            </div>
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>