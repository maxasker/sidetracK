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
    <div id="elem"></div>
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
            
           <!---knapparna för de olika kategorierna, skickar med like,classified eller dislike i pythonfunktionen--->
                <div class="categories">
                        %like = "like"
                        <a href="/threadoverview/{{like}}/1">
                            <div class="catdiv"><img class="catpic" src="{{url('static',filename='static/like.png')}}" alt="Picture of love"></li>
                        </a></div>
                        %classified = "classified"
                        <a href="/threadoverview/{{classified}}/1">
                            <div class="catdiv"><img class="catpic" src="{{url('static',filename='static/classified.png')}}" alt="Picture of classified">
                        </a></div>
                        %dislike = "dislike"
                        <a href="/threadoverview/{{dislike}}/1">
                            <div class="catdiv"><img class="catpic"  src="{{url('static',filename='static/unlike.png')}}" alt="Picture of dislike"</div></a>
                            </div>
            <!-----Text som visar vilken kategori man befinner sig på, finns mellan trådkategorierna och trådinnehållet--->
                    <h1 id = "threadcategori">{{threadcategori}}</h1>
                
                <div id="createthread"><a href="/{{threadcategori}}/createthread" id="createthreadtext">Skapa tråd</a></div>


            
            <!----Länkar in javascripten ---->
            <script src="{{url('static',filename='static/jq/jquery-1.12.3.min.js')}}"></script>
            <script src="{{url('static', filename='static/jq/jquery-ui.js')}}"></script>
            <script src="{{url('static',filename='static/jq/script.js')}}"></script>
            <div class="singlethreadbox">
                
            <!-----skapar en variabel för svaraknappen som är skriven i javascript ----->
            <script>
                var formLink = "/{{threadcategori}}/{{threadname}}/savenewcomment";
            </script>
                
<!--------------------------------------------------------------------------------------------------------------------------------------->
            <div id = "tsboxen">
                <!----Knappen för att svara på TS --->
                <a id="replythread" href="javascript:void(0)" onclick="showReplyBox(44,142,'comments.php',0);">Svara på tråden</a>
                
                <!---datumochtid för TS, variabel ifrån python ---->
                <p>{{threadinfo}}</p>
                
                <!---Trådnamnet(titeln) där vi tar bort _____, variabel ifrån python-->
                <h1>{{threadname.replace("_____", " ")}}</h1>
                
                <!---texten för TS, variabel ifrån python--->
		        <p>{{threadtext}}</p>
                
                <!--- if else för vad det är för ext, är det en gif har vi en spelare i javascript vi länkar in annars bara en <img> -->
                %if tsimg == "tsimg.gif":
                <script src="/static/gifffer.min.js"></script>
                <img data-gifffer="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %else:
                <img class="singleboximg" src="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %end
            </div>
            <hr>
                
            <!---forloop för kommentarslistan man får ifrån python --->
            <!---För varje mapp i kommentarslistan --->
            %for mapp in commentlist:
                
                <!---Skapa en lista för filerna i mappen--->
                %files = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
                
                <!---gör en ny lista men bara med filer som slutar på .txt--->
                %filelist = [i for i in files if i.endswith('.txt')]
                
                <!---Sortera listan--->
                %sorted(filelist)
                
                <!---För varje textfil i nya listan--->
                %for textfile in filelist:
                
                <!---Om textfilen är comment1.txt så är det en originalkommentar, då gör vi lite annorlunda--->
                %if textfile == "comment1.txt":
                
                    <!---f = textfilen --->
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                
                    <!---Läs första linen och skriv ut den i egen <p> och skriv ut svaraknappen --->
                    %line_0 = f.readlines()[0]
                    <div class="threadcomment">
                        <a href="javascript:void(0)" onclick="showReplyBox2(44,142,'comments.php',0, this);" data-form-link="/{{threadcategori}}/{{threadname}}/{{mapp}}/savenewcommentcomment">Svara</a>
                        <p>{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                    
                    <!---Stäng filen--->
                    %f.close()
                    
                    <!---Öppna den och skriv ut alla andra linjer förutom första (som bara är datum och tid)--->
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                    %for line in lines_1_through_end:
                        <p>{{line.decode('iso-8859-1').encode('utf8')}}</p>
                    %end
                    
                    <!--- Kollar om det finns en bild och skriver ut den, är det gif så används ramverket annar bara <img> --->
                    %if os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.png".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.png".format(threadcategori,threadname,mapp)
                        <img class="singleboximg" src="{{url('static',filename=commentimgpath)}}" alt="tsimg"></div>
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.jpg".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.jpg".format(threadcategori,threadname,mapp)
                        <img class="singleboximg" src="{{url('static',filename=commentimgpath)}}" alt="tsimg"></div>
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.jpeg".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.jpeg".format(threadcategori,threadname,mapp)
                        <img class="singleboximg" src="{{url('static',filename=commentimgpath)}}" alt="tsimg"></div>
                    %elif os.path.isfile("static/threads/{0}/{1}/comments/{2}/comment1.gif".format(threadcategori,threadname,mapp)):
                        %commentimgpath = "static/threads/{0}/{1}/comments/{2}/comment1.gif".format(threadcategori,threadname,mapp)
                        <script src="/static/gifffer.min.js"></script>
                        <img data-gifffer="{{url('static',filename=commentimgpath)}}" alt="tsimg"></div>
                    %else:
                        </div>
                    %end

                <!---Fortsättning ifrån första loopen om det inte är originalkommentar --->
                %else:

                <!---Öppna textfilen och läs rad 1 (0 i python) och skriv ut tid och datum--->
                %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %line_0 = f.readlines()[0]
                    <div class="commentcomment">
                        <p>{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                        
                    <!---Stäng filen--->
                    %f.close()
                        
                    <!---Öppna den igen och skriv ut alla andra rader--->
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                    %for line in lines_1_through_end:
                        <p>{{line}}</p>
                    %end
                        
                    <!---Om det finns en bild skrivs den ut, är det gif så används ramverket annars bara en vanlig <img>--->
                    %if os.path.isfile('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".jpg"))):
                        %commentcommentimgpath = 'static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".jpg"))
                        <img class="singleboximg" src="{{url('static',filename=commentcommentimgpath)}}" alt="commentcommentimg">
                    %elif os.path.isfile('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".png"))):
                        %commentcommentimgpath = 'static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".png"))
                        <img class="singleboximg" src="{{url('static',filename=commentcommentimgpath)}}" alt="commentcommentimg">
                    %elif os.path.isfile('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".jpeg"))):
                        %commentcommentimgpath = 'static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".jpeg"))
                        <img class="singleboximg" src="{{url('static',filename=commentcommentimgpath)}}" alt="commentcommentimg">
                    %elif os.path.isfile('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".gif"))):
                        %commentcommentimgpath = 'static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile.replace(".txt",".gif"))
                        <script src="/static/gifffer.min.js"></script>
                        <img data-gifffer="{{url('static',filename=commentcommentimgpath)}}" alt="tsimg">
                    %end
                    </div>

                <!---Stäng filen--->
                %f.close()
                %end
                %end
                <hr>
            %end
            </div>

            <footer>
                <p id="footer">sidetracKz0r banana inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>