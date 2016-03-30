# -*- coding: cp1252 -*-
from bottle import run, route, template, request, static_file
from bottle import static_file
from bottle import url
import os

@route('/')
def index():
        return template("index")

@route('/threadshow')
def threadshow():
    #threadlista = os.walk(static/threads).next()[1]
    threadlist = "lol"
    return template("thread", threadlist=threadlist)

@route('/threadoverview')
def threadoverview():
    return template("threadoverview")

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

@route('/static/')
def server_static(filepath):
    return static_file(filepath, root='/sidetracK')

run(host='localhost', port=9057, debug=True, reloader=True)

