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

@route('/Static/<filename>')
def server_static(filename):
    return static_file(filename, root='Static')

run(host='localhost', port=9057, debug=True, reloader=True)

