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
        <div id="elem"></div>
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
                <a id="reportthread" href="/reportts/{{threadname}}">Report</a>
                
                <!----Knappen för att svara på TS --->
                %if commentcounter2 < 200:
                <a id="replythread" href="javascript:void(0)" onclick="showReplyBox(44,142,'comments.php',0);">Svara på tråden</a>
                %else:
                <p id="replythread">THREAD CLOSED</p>
                %end
                <!---datumochtid för TS, variabel ifrån python ---->
                <p>{{threadinfo}}</p>
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
                <!---Trådnamnet(titeln) där vi tar bort _____, variabel ifrån python-->
                <h1 id="singlethreadh1">{{threadname}}</h1>
                %threadname = tempholder
                <!--- if else för vad det är för ext, är det en gif har vi en spelare i javascript vi länkar in annars bara en <img> -->
                %if tsimg == "tsimg.gif":
                <script class="singleboximg" src="/static/gifffer.min.js"></script>
                <img data-gifffer="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %else:
                <img class="singleboximg" src="{{url('static',filename=tsimgpath)}}" alt="tsimg">
                %end
                %counter2 = 0
                %for word in threadtext.split():
                %if len(word) > 50:
                %counter2 = counter2 + 1
                %end
                %end
                %if counter2 > 0:
                <div id="singletslongword">{{threadtext}}</div>
                %else:
                <div id="threadcontent">{{threadtext}}</div>
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
                        %if commentcounter2 < 200:
                        <a href="javascript:void(0)" onclick="showReplyBox2(44,142,'comments.php',0, this);" data-form-link="/{{threadcategori}}/{{threadname}}/{{mapp}}/savenewcommentcomment">Svara</a>
                        %end
                        <p>{{line_0.decode('iso-8859-1').encode('utf8')}}</p>
                    
                    <!---Stäng filen--->
                    %f.close()
                    
                    <!---Öppna den och skriv ut alla andra linjer förutom första (som bara är datum och tid)--->
                    %f= open('static/threads/{0}/{1}/comments/{2}/{3}'.format(threadcategori,threadname,mapp,textfile), 'r')
                    %lines_1_through_end = f.readlines()[1:]
                    %counter3 = 0
                    %for line in lines_1_through_end:
                        %for word in line.split():
                            %if len(word) > 50:
                                %counter3 = counter3 +1
                    %end
                    %end
                    %end
                    %for line in lines_1_through_end:
                        %if counter3 > 0:
                        <p id="commentlongword">{{line}}</p>
                        %else:
                        <p id="commenttext">{{line}}</p>
                        %end
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
                        <img class="singleboximg" data-gifffer="{{url('static',filename=commentimgpath)}}" alt="tsimg"></div>
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
                    %counter4 = 0
                    %for line in lines_1_through_end:
                        %for word in line.split():
                            %if len(word) > 50:
                                %counter4 = counter4 +1
                    %end
                    %end
                    %end
                    %for line in lines_1_through_end:
                        %if counter4 > 0:
                        <p id="commentcommentlongword">{{line}}</p>
                        %else:
                        <p id="commentcommenttext">{{line}}</p>
                        %end
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
                        <script class="singleboximg" src="/static/gifffer.min.js"></script>
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
                <p id="footer">sidetracK inc</p>
                <p id="createfooter">By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
		
			<script>
				
				var storedArray = JSON.parse(localStorage.getItem("latest"));
				
				if (storedArray == null){
					var latestArr = [];
					latestArr.push(window.location.href);
					localStorage.setItem("latest", JSON.stringify(latestArr));
				}
				
				else {
					var testArr = window.location.href;
					var i = storedArray.length;
					while (i--){
						if(storedArray[i] == testArr){
							break;
							}
					
						else{
							var j = storedArray.length;
							if(j === 5){
								storedArray.pop();
								storedArray.unshift(window.location.href);
								localStorage.setItem("latest", JSON.stringify(storedArray));
								break;
								
							}
							
							else{
								storedArray.push(window.location.href);
								localStorage.setItem("latest", JSON.stringify(storedArray));
								break;
							}
						}
						
					}
						
					
				}
				
				

			</script>
    </body>
</html>