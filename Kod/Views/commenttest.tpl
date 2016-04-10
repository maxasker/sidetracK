<!DOCTYPE HTML>
% from bottle import url
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>sidetracK</title>
        <link href="{{url('static',filename='style.css')}}" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="container">
    
            <form action="/{{threadcategori}}/{{threadname}}/savenewcomment" method="post">
	        <h1>Brödtext</h1>
	        <textarea name="text" placeholder="text" maxlength="2000" rows="5" cols="50">Text</textarea>
	        <hr>
	        <input type="submit" value="Spara innehåll">
            </form>

        
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>