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
                        <li role="presentation"><a href="#">Messages</a></li>
                        <li role="presentation"><a href="thread.tpl">Kom till tråden</a></li>
                    </ul>
                </nav>
            </div>
            <div class="btn-toolbar">
                <button type="button" class="btn btn-default">Left</button>
                <button type="button" class="btn btn-default">Middle</button>
                <button type="button" class="btn btn-default">Right</button>
            </div>
        
            <footer>
                <p id="sidfot">sidetracKz0r inc</p>
                <p>By Johannes, Simon, Max, Jacob and Per</p>
            </footer>
        </div>
    </body>
</html>