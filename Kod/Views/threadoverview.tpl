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
                <!-- Sidetrack logga--> 
                <div class="main-logotype">
                    <header>
                        <a class="main-logotype" href="/homepage">sidetracK</a>
                    </header>
                </div>
              <!-- Navigations bar. Med lite bootstrap styling -->
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
            <!-- Navigationen för hemsidans tre huvudkategorier som följer med oavsett vilken kategori man besöker -->
               <div id="categories">
                <ul>
                    %like = "like"
                    <a href="/threadoverview/{{like}}/1">
                        <li><img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love"></li>
                    </a>
                    %classified = "classified"
                    <a href="/threadoverview/{{classified}}/1">
                        <li><img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified"></li>
                    </a>
                    %dislike = "dislike"
                    <a href="/threadoverview/{{dislike}}/1">
                        <li><img class="catpic" src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></li>
                    </a>
                </ul>
                <h1 id = "threadcategori">{{threadcategori}}</h1>
            </div>
            
            <!-- Max och Simon skall kommentera nedan -->
            <div id="createthread"><a href="/{{threadcategori}}/createthread" id="createthreadtext">Skapa tråd</a></div>
            <div class="likebox">    
                % for threadname in threads:
                %tsthreadinfo = open("static/threads/{1}/{0}/tsinfo.txt".format(threadname,threadcategori), "r")
                %threadinfo = tsthreadinfo.read()
                %tsthreadinfo.close()
                %threadtextfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
                %threadtext = threadtextfile.read()
                %threadtextfile.close()
                <div class = "tsboxoverview">
                <p class = "tsdatetimeoverview">{{threadinfo}}</p>
                <a href="/{{threadcategori}}/thread/{{threadname}}" class = "tsreplybuttoverview">Klicka här för att titta på tråden</a>
                <h2 class = "tsheadlineoverview">{{threadname.replace("_____", " ")}}</h2>
                %if os.path.isfile("static/threads/{1}/{0}/tsimg.jpg".format(threadname,threadcategori)):
                %tsimgpath = "static/threads/{1}/{0}/tsimg.jpg".format(threadname,threadcategori)
                <img class = "tsimgoverview" src="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %elif os.path.isfile("static/threads/{1}/{0}/tsimg.png".format(threadname,threadcategori)):
                %tsimgpath = "static/threads/{1}/{0}/tsimg.png".format(threadname,threadcategori)
                <img class = "tsimgoverview" src="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %elif os.path.isfile("static/threads/{1}/{0}/tsimg.jpeg".format(threadname,threadcategori)):
                %tsimgpath = "static/threads/{1}/{0}/tsimg.jpeg".format(threadname,threadcategori)
                <img class = "tsimgoverview" src="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %elif os.path.isfile("static/threads/{1}/{0}/tsimg.gif".format(threadname,threadcategori)):
                %tsimgpath = "static/threads/{1}/{0}/tsimg.gif".format(threadname,threadcategori)
                <script src="/static/gifffer.min.js"></script>
                <img class = "tsimgoverview" data-gifffer="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %end
                <p class = "tstextoverview">{{threadtext}}</p>
                </div>
                %commentcounter = 0
                %commentlist = os.walk('static/threads/{0}/{1}/comments'.format(threadcategori,threadname)).next()[1]
                %if len(commentlist) == 1:
                    %commentlimit = 1
                    %elif len(commentlist) == 2:
                    %commentlimit = 2
                    %elif len(commentlist) == 3 or len(commentlist) > 3:
                    %commentlimit = 3
                %end
                %if len(commentlist) == 0:
                
                %else:
                    <hr>
                    %for mapp in commentlist:
                    %if not (commentcounter == commentlimit):
                    %f= open("static/threads/{0}/{1}/comments/{2}/comment1.txt".format(threadcategori,threadname,mapp), 'r')
                    %line_0 = f.readlines()[0]
                    <div class="threadcommentoverview">
                    <p class = "commentdatetimeoverview">{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                    %if os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.png".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.png".format(threadcategori,threadname,mapp)
                        <img class = "commentimgoverview" src="{{url('static',filename=commentimgpath)}}" alt="commentimg">
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.jpg".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.jpg".format(threadcategori,threadname,mapp)
                        <img class = "commentimgoverview" src="{{url('static',filename=commentimgpath)}}" alt="commentimg">
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.jpeg".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.jpeg".format(threadcategori,threadname,mapp)
                        <img class = "commentimgoverview" src="{{url('static',filename=commentimgpath)}}" alt="commentimg">
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.gif".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.gif".format(threadcategori,threadname,mapp)
                        <script class = "commentimgoverview" src="/static/gifffer.min.js"></script>
                        <img data-gifffer="{{url('static',filename=commentimgpath)}}" alt="commentimg">
                    %end
                    %f.close()
                    %f= open("static/threads/{0}/{1}/comments/{2}/comment1.txt".format(threadcategori,threadname,mapp), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                        %for line in lines_1_through_end:
                        <p class = "commenttextoverview">{{line.decode('iso-8859-1').encode('utf8')}}</p>
                        %end
                    </div>
                        %if not (commentcounter == (commentlimit-1)):
                        <hr>
                        %end
                    %commentcounter = commentcounter+1
                    %end
                    %end
                %end
		        <hr>
		        % end
                </div>
            
            <div class="latestpost">
                <h2>Latest Post</h2>
            
                
            </div>
            %tcat = threadcategori
            
        <ul class="pagination">
        <li class="disable"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
            <li class="active"><a href="/threadoverview/{{tcat}}/1">1<span class="sr-only">(current)</span></a></li>  
            <li class="disable"><a href="/threadoverview/{{tcat}}/2">2<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/3">3<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/4">4<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/5">5<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/6">6<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/7">7<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/8">8<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/9">9<span class="sr-only">(current)</span></a></li> 
            <li class="disable"><a href="/threadoverview/{{tcat}}/10">10<span class="sr-only">(current)</span></a></li> 
        </ul>
            
        <!--    <div class="pages">
                <a href="/threadoverview/{{tcat}}/1">1</a>
                <a href="/threadoverview/{{tcat}}/2">2</a>
                <a href="/threadoverview/{{tcat}}/3">3</a>
                <a href="/threadoverview/{{tcat}}/4">4</a>
                <a href="/threadoverview/{{tcat}}/5">5</a>
                <a href="/threadoverview/{{tcat}}/6">6</a>
                <a href="/threadoverview/{{tcat}}/7">7</a>
                <a href="/threadoverview/{{tcat}}/8">8</a>
                <a href="/threadoverview/{{tcat}}/9">9</a>
                <a href="/threadoverview/{{tcat}}/10">10</a>
            </div> -->
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>