<!DOCTYPE HTML>
% from bottle import url
% import os
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
            </div>
                <div id="testruta">
                    <div class="middle-bar">
                        <ul class="nav nav-tabs">
                            <li role="presentation" class="nav-butt"><a href="#">Like</a>
                            </li>
                            <li role="presentation" class="nav-butt"><a href="#">Classified</a>
                            </li>
                            <li role="presentation" class="nav-butt"><a href="#">Dislike</a>       
                            </li>
                        </ul>
                    </div>
            <div><a href="/{{threadcategori}}/createthread">Skapa tråd</a>    
                </div>
            <div class="likebox">
                % for threadname in threads:
                %threadtextfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
                %threadtext = threadtextfile.read()
                %threadtextfile.close()
                <a href="/{{threadcategori}}/thread/{{threadname}}">Klicka här fitthue</a>
		        <h2>{{threadname.replace("_____", " ")}}</h2>
                <p>{{threadtext}}</p>
		        <hr>
		        % end
                </div>
            
                </div>
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>