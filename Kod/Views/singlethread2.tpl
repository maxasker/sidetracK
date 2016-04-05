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
                    <button id="rubrik"><h1>sidetracK</h1></button>
                </header>
                </div>
             <div class="top-bar">
                <nav>
                    <ul class="nav nav-pills">
                        <li role="presentation" class="active"><a href="#">Home</a></li>
                        <li role="presentation"><a href="#">Profile</a></li>
                        <li role="presentation"><a href="/threadoverview">Messages</a></li>
                        <li role="presentation"><a href="/threadshow">Kom till tråden</a></li>
                    </ul>
                </nav>
            </div>
            <div id="tsbox">
            <a href="/createnewcomment/{{threadname}}/{{threadtext}}">Klicka här fitthue för att svara</a>
            <h1>{{threadname.replace("_____", " ")}}</h1>
		    <p>{{threadtext}}</p>
            %for mapp in commentlist:
                %filelist = os.listdir("static/threads/like/{0}/comments/comment1/".format(threadname))
                %for textfile in filelist:
                %commentfile = open("static/threads/like/{0}/comments/{1}/{2}".format(threadname,mapp,textfile), "r")
                %commenttext = commentfile.read()
                %commentfile.close()
                %if textfile == "comment1.txt":
                    <p>{{commenttext.decode('iso-8859-1').encode('utf8')}}</p>
                %else:
                    <p>{{commenttext.decode('iso-8859-1').encode('utf8')}}</p>
                %end
                %end
            %end
            </div>
        
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>