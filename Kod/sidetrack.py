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
    return template("savenewthread")

@route('/lookatsinglethread/<threadname>')
def lookatsinglethread(threadname):
    singlethreadfile = open("static/threads/like/{0}/tstext.txt".format(threadname), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    commentlist = os.walk('static/threads/like/{0}/comments'.format(threadname)).next()[1]
    return template("singlethread2", threadname=threadname, threadtext=threadtext, commentlist=commentlist)

@route('/threadoverview')
def threadoverview():
    threadlist = os.walk('static/threads/like').next()[1]
    return template("threadoverview", threads=threadlist)

@route('/createnewcomment/<threadname>/<threadtext>')
def createnewcomment(threadname,threadtext):
    return template("commenttest", threadname=threadname, threadtext=threadtext)

@route('/savenewcomment/<threadname>/<threadtext>', method="POST")
def savenewcomment(threadname,threadtext):
    counter = 1
    newpath2 = r'static/threads/like/{1}/comments/comment{0}'.format(counter, threadname)
    checkifdirexists(newpath2,counter,threadname)
    commenttext = request.forms.get("text")
    newpath = r'static/threads/like/{1}/comments/comment{0}/comment1.txt'.format(counter, threadname)
    checkifcommentexists(newpath,counter,commenttext,threadname)
    return template("singlethread2", threadname=threadname, threadtext=threadtext)

def checkifdirexists(newpath2,counter,threadname):
    if not os.path.exists(newpath2):
        os.makedirs(newpath2)
    else:
        counter = counter+1
        newpath2 = r'static/threads/like/{1}/comments/comment{0}'.format(counter, threadname)
        checkifdirexists(newpath2,counter,threadname)
    return counter

def checkifcommentexists(newpath,counter,commenttext,threadname):
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/like/{1}/comments/comment{0}/comment1.txt'.format(counter, threadname)
        checkifcommentexists(newpath,counter,commenttext,threadname)
    else:
        createcommentfile(commenttext,threadname,newpath)

def createcommentfile(commenttext,threadname,newpath):
    newcommentfile = open("{0}".format(newpath), "w")
    newcommentfile.write(commenttext)
    newcommentfile.close()

@route('/savenewthreadlike', method="POST")
def savethread():
    title = request.forms.get("title").replace(" ", "_____")
    text = request.forms.get("text")
    newpath2 = r'static/threads/like/{0}'.format(title)
    newpath = r'static/threads/like/{0}/comments'.format(title) 
    if not os.path.exists(newpath):
        os.makedirs(newpath)

    newthreadtitlefile = open("{0}/tstitle.txt".format(newpath2), "w")
    newthreadtitlefile.write(title)
    newthreadtitlefile.close()

    newthreadtextfile = open("{0}/tstext.txt".format(newpath2), "w")
    newthreadtextfile.write(text)
    newthreadtextfile.close()
    title = []
    return template("singlethread", tspath=newpath2)

@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static')

run(host='localhost', port=9108, debug=True, reloader=True)

