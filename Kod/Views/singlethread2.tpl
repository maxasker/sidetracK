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
                <!-- Sidetrack logga -->
                <div class="main-logotype">
                    <header>
                        <a class="main-logotype" href="/homepage">sidetracK</a>
                    </header>
                </div>
            <!-- Navigationsruta med lite bootstrap design -->
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
            <div id='elem' onmousedown='tzdragg.startMoving(event);' onmouseup='tzdragg.stopMoving();'  > </div>
            <a id="replythread" href="javascript:void(0)" onclick="showReplyBox(44,142,'comments.php',0);">Svara på tråden</a>
            <p>{{threadinfo}}</p>
            <h1>{{threadname.replace("_____", " ")}}</h1>
		    <p>{{threadtext}}</p>
            %if tsimg == "tsimg.gif":
            <script src="/static/gifffer.min.js"></script>
            <img data-gifffer="{{url('static',filename=tsimgpath)}}" alt="tsimg">
            %else:
            <img src="{{url('static',filename=tsimgpath)}}" alt="tsimg">
            %end
            <hr>
                <script src="/static/javascript.js"></script>
            %for mapp in commentlist:
                %files = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
                %filelist = [i for i in files if i.endswith('.txt')]
                %for textfile in filelist:
                %if textfile == "comment1.txt":
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %line_0 = f.readlines()[0]
                    <div class="threadcomment">
                    <a href="javascript:void(0)" onclick="showReplyBox2(44,142,'comments.php',0, this);" data-form-link="/{{threadcategori}}/{{threadname}}/{{mapp}}/savenewcommentcomment">Svara</a>
                    <p>{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                    %f.close()
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                    %for line in lines_1_through_end:
                    <p>{{line.decode('iso-8859-1').encode('utf8')}}</p>
                    %if os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.png".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.png".format(threadcategori,threadname,mapp)
                        <img src="{{url('static',filename=commentimgpath)}}" alt="tsimg">
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.jpg".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.jpg".format(threadcategori,threadname,mapp)
                        <img src="{{url('static',filename=commentimgpath)}}" alt="tsimg">
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.jpeg".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.jpeg".format(threadcategori,threadname,mapp)
                        <img src="{{url('static',filename=commentimgpath)}}" alt="tsimg">
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.gif".format(threadcategori,threadname,mapp)):
                    %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.gif".format(threadcategori,threadname,mapp)
                    <script src="/static/gifffer.min.js"></script>
                    <img data-gifffer="{{url('static',filename=commentimgpath)}}" alt="tsimg">
                    %end
                    %end
                    </div>
                %else:
                %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %line_0 = f.readlines()[0]
                    <div class="commentcomment">
                    <p>{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                    %f.close()
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                    %for line in lines_1_through_end:
                    <p>{{line.decode('iso-8859-1').encode('utf8')}}</p>
                    %end
                    </div>
                %end
                %f.close()
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