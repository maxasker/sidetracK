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
                <div id="testruta">
                 
            <div><a href="/{{threadcategori}}/createthread">Skapa tråd</a>    
                </div>
            <div class="likebox">
                % for threadname in threads:
                %threadtextfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
                %threadtext = threadtextfile.read()
                %threadtextfile.close()
                <a href="/{{threadcategori}}/thread/{{threadname}}">Klicka här för att titta på tråden</a>
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