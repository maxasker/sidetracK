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
                        <li role="presentation"><a class="nav-text" id="feedback" href="/feedback">Feedback</a>
                        </li>
                        <li role="presentation"><a class="nav-text" href="/about">About us</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <!---knapparna för de olika kategorierna, skickar med like,classified eller dislike i pythonfunktionen--->
                   <div class="categories">
                        <div class = "picposition">
                        %like = "like"
                        <a id = "picbull" href="/threadoverview/{{like}}/1">
                            <img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love">
                        </a>
                        %classified = "classified"
                        <a id = "picbull"href="/threadoverview/{{classified}}/1">
                            <img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified">
                        </a>
                        %dislike = "dislike"
                        <a id = "picbull"  href="/threadoverview/{{dislike}}/1">
                            <img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"></a>
        </div>
                    </div>
            <!-----Text som visar vilken kategori man befinner sig på, finns mellan trådkategorierna och trådinnehållet--->
                    <h1 id = "threadcategori">{{threadcategori}}</h1>
                
            <div id="createthreadtext"><a id="createthreada" href="/{{threadcategori}}/createthread">Skapa tråd</a></div>


            <!---Skapar en div för alla trådar i kategorin--->
            <div class="likebox">
                
                <!---Skapar en loop ifrån listan som man får ifrån python med trådmappar--->
                <!---För varje trådmapp i trådlistan--->
                % for threadname in threads:
                
                <!---Öppna trådmappen och spara TS datum och tid och spara i threadinfo--->
                %tsthreadinfo = open("static/threads/{1}/{0}/tsinfo.txt".format(threadname,threadcategori), "r")
                %threadinfo = tsthreadinfo.read()
                %tsthreadinfo.close()
                
                <!---Öppna trådmappen och spara vad som står i TS brödtext-->
                %threadtextfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
                %threadtext = threadtextfile.read()
                %threadtextfile.close()
                
                <!---Starta en div för TS och skriv ut datum och tid och knapp för att titta på tråden och skriv ut rubriken--->
                <div class = "tsboxoverview">
                    <a id="reportthread" href="/reportts/{{threadname}}">Report</a>
                    <p class = "tsdatetimeoverview">{{threadinfo}}</p>
                    <a href="/{{threadcategori}}/thread/{{threadname}}" class = "tsreplybuttoverview">Klicka här för att titta på tråden</a>
                    %tempholder = threadname
                    %threadname = threadname.replace("─", " ")
                    %threadname = threadname.replace("∽", "≺")
                    %threadname = threadname.replace("╶ ", "≻")
                    %threadname = threadname.replace("╾", "?")
                    %threadname = threadname.replace("━", "/")
                    %threadname = threadname.replace("─", "\\")
                    %threadname = threadname.replace("╸", ":")
                    %threadname = threadname.replace("╾", "*")
                    %threadname = threadname.replace("┅", '"')
                    <h2 class = "tsheadlineoverview">{{threadname}}</h2>
                    %threadname = tempholder
                    <!---Kolla vilken extention som bilden har och skriv ut, är det gif används ramverk annars bara <img>--->
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
                    %counter1 = 0
                    %for word in threadtext.split():
                        %if len(word) > 50:
                            %counter1 = counter1 +1
                    %end
                    %end
                    %if counter1 > 0:
                    <p id="tstextoverviewlongword">{{threadtext}}</p>
                    %else:
                    <p id="tstextoverview">{{threadtext}}</p>
                    %end
                </div>
                
                <!---Vi skriver bara ut originalkommentarer och högst tre av dem--->
                
                <!---Gör en lista med kommentarer, räknar hur många kommentarer som finns, det är för att inte få för många breaks--->
                %commentcounter = 0
                %commentlist = os.walk('static/threads/{0}/{1}/comments'.format(threadcategori,threadname)).next()[1]
                %if len(commentlist) == 1:
                    %commentlimit = 1
                    %elif len(commentlist) == 2:
                    %commentlimit = 2
                    %elif len(commentlist) == 3 or len(commentlist) > 3:
                    %commentlimit = 3
                %end
                <!---Om listan är tom så gör inget--->
                %if len(commentlist) == 0:
                
                <!---Annars gå igenom commentlisten--->
                %else:
                    
                    <!---Gör en break--->
                    
                
                    <!---För varje mapp i kommentarslistan--->
                    %for mapp in commentlist:
                    
                    <!---Om räknaren för kommentarer inte har kommit upp i limiten--->
                    %if not (commentcounter == commentlimit):
                    
                    <!---Öppna första originalkommentaren och läs första raden med tid och datum, gör ny div och skriv ut tid/datum--->
                    %f= open("static/threads/{0}/{1}/comments/{2}/comment1.txt".format(threadcategori,threadname,mapp), 'r')
                    %line_0 = f.readlines()[0]
                    <div class="threadcommentoverview">
                        <p class = "commentdatetimeoverview">{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                        
                    <!---Om det finns en bild så skriv ut, är det en gif används ramverk annars vanlig <img>--->
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
                    
                    <!---Stäng filen--->
                    %f.close()
                    
                    <!---Öppna filen igen och skriv ut resterade text--->
                    %f= open("static/threads/{0}/{1}/comments/{2}/comment1.txt".format(threadcategori,threadname,mapp), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                    %counter2 = 0
                    %for line in lines_1_through_end:
                        %for word in line.split():
                            %if len(word) > 50:
                                %counter2 = counter2 +1
                    %end
                    %end
                    %end
                        %for line in lines_1_through_end:
                        %if counter2 > 0:
                        <p class = "commenttextoverview" id="commenttextlongwordid">{{line}}</p>
                        %else:
                        <p class = "commenttextoverview" id="commenttextid">{{line}}</p>
                        %end
                        %end
                    </div>
                
                        <!---Om det inte är sista kommentaren så skriv ut en break--->
                        %if not (commentcounter == (commentlimit-1)):
                        
                        %end
                    %commentcounter = commentcounter+1
                    %end
                    %end
                %end
                
                <!---Break efter varje trådvisningssektion--->
		        <hr>
		        % end
                </div>
            <div class="latestpost">
                <h2>Latest Post</h2>
            
                
            </div>
            %tcat = threadcategori
            
        <ul id="pages" class="pagination" data-page="{{page}}">
            <li class="disable"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
            <li class="disable"><a href="/threadoverview/{{tcat}}/1">1<span class="sr-only">(current)</span></a></li>
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
            
        </div>
        <footer class="footer">
                <p id="footinc">sidetracK inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
        </footer>
        
        <script src="/static/js/jquery.js"></script>
        <script>
            var page = $("#pages").attr("data-page");
            $.each($("#pages li"), function(){
                if(page + "(current)" == $(this).text()){
                    $(this).attr("class", "active");
                }
            });
        </script>
    </body>
</html>