# -*- coding: cp1252 -*-
from bottle import run, route, template, request, static_file, get, post, error
from bottle import static_file
from bottle import url
import os

@route('/')
def index():
    return template("index")

@route('/threadshow')
def threadshow():
    #threadlist = os.walk(static/threads).next()[1]
    return template("thread")

@route('/threadoverview')
def threadoverview():
    fillista = listdir('static/threads/')
    return template("threadoverview", lista=fillista)

@route('/savenewthread', method="POST")
def savethread():
    title = request.forms.get("title").replace(" ", "_____")
    text = request.forms.get("text")
    newpath = r'static/threads/{0}'.format(title) 
    if not os.path.exists(newpath):
        os.makedirs(newpath)

    newthreadtitlefile = open("{0}/tstitle.txt".format(newpath), "w")
    newthreadtitlefile.write(title)
    newthreadtitlefile.close()

    newthreadtextfile = open("{0}/tstext.txt".format(newpath), "w")
    newthreadtextfile.write(text)
    newthreadtextfile.close()
    return template("singlethread", tspath=newpath)

@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static')

run(host='localhost', port=9062, debug=True, reloader=True)

