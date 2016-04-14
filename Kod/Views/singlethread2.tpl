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
            <div class="tsbox">
            %commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
            %singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
            %threadtext = singlethreadfile.read()
            <script>
                var formLink = "/{{threadcategori}}/{{threadname}}/savenewcomment";
            </script>
            <script src="/static/javascript.js"></script>
            <div id='elem' onmousedown='tzdragg.startMoving(event);' onmouseup='tzdragg.stopMoving();'  > </div>
            <a href="javascript:void(0)" onclick="showReplyBox(44,142,'comments.php',0);">javascriptsvar</a>
            <a href="/{{threadcategori}}/{{threadname}}/createnewcomment">Klicka här för att svara</a>
            <h1>{{threadname.replace("_____", " ")}}</h1>
		    <p>{{threadtext}}</p>
            %for mapp in commentlist:
                %filelist = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
                %for textfile in filelist:
                %commentfile = open("static/threads/{0}/{1}/comments/{2}/{3}".format(threadcategori,threadname,mapp,textfile), "r")
                %commenttext = commentfile.read()
                %commentfile.close()
                %if textfile == "comment1.txt":
                <script>
                var formLinkDos = "/{{threadcategori}}/{{threadname}}/{{mapp}}/savenewcommentcomment";
                </script>
                <div class="threadcomment">
                    <a href="javascript:void(0)" onclick="showReplyBox2(44,142,'comments.php',0);">javascriptsvarDOS</a>
                    <p>{{commenttext.decode('iso-8859-1').encode('utf8')}}</p>
                </div>
                %else:
                <div class="commentcomment">
                    <p>{{commenttext.decode('iso-8859-1').encode('utf8')}}</p>
                    
                </div>
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