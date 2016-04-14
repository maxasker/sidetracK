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
                        <li role="presentation"><a class="nav-text" id="feedback" href="/threadoverview">Feedback</a>
                        </li>
                        <li role="presentation"><a class="nav-text" href="/createthread">Om oss</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div id="categories">
                <ul>
                    %like = "like"
                    <a href="/threadoverview/{{like}}">
                        <li><img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love"></li>
                    </a>
                    %classified = "classified"
                    <a href="/threadoverview/{{classified}}">
                        <li><img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified"></li>
                    </a>
                    %dislike = "dislike"
                    <a href="/threadoverview/{{dislike}}">
                        <li><img class="catpic" src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></li>
                    </a>
                </ul>
                <h1 id = "threadcategori">{{threadcategori}}</h1>
            </div>
            <div class="likebox">
            <script>
                var formLink = "/{{threadcategori}}/{{threadname}}/savenewcomment";
            </script>
            <script src="/static/javascript.js"></script>
            <div id='elem' onmousedown='tzdragg.startMoving(event);' onmouseup='tzdragg.stopMoving();'  > </div>
            <a id="replythread" href="javascript:void(0)" onclick="showReplyBox(44,142,'comments.php',0);">Svara på tråden</a>
            <h1>{{threadname.replace("_____", " ")}}</h1>
		    <p>{{threadtext}}</p>
            <hr>
            %for mapp in commentlist:
                %filelist = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
                %filelist.sort()
                %for textfile in filelist:
                %commentfile = open("static/threads/{0}/{1}/comments/{2}/{3}".format(threadcategori,threadname,mapp,textfile), "r")
                %commenttext = commentfile.read()
                %commentfile.close()
                %if textfile == "comment1.txt":
                <div class="threadcomment">
                    <a href="javascript:void(0)" onclick="showReplyBox2(44,142,'comments.php',0, this);" data-form-link="/{{threadcategori}}/{{threadname}}/{{mapp}}/savenewcommentcomment">Svara</a>
                    <p>{{commenttext}}</p>
                </div>
                %else:
                <div class="commentcomment">
                    <p>{{commenttext}}</p>
                    
                </div>
                %end
                %end
                <hr>
            %end
            </div>
        
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>