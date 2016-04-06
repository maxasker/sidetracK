#!/usr/bin/env python
# -*- coding: utf-8 -*-
from bottle import run, route, template, request, static_file, get, post, error
from bottle import static_file
from bottle import url
from bottle import redirect
import os
import sys

@route('/')
def index():
    return template("index")

@route('/homepage')
def homepage():
    redirect('/')
    

@route('/<threadcategori>/createthread')
def threadshow(threadcategori):
    threadcategori = threadcategori
    return template("savenewthread", threadcategori=threadcategori)

@route('/redirthread/<threadcategori>/<threadname>')
def redirectthreads(threadcategori,threadname):
    #NÅGOT FEL HÄR
    redirect('/<threadcategori>/thread/<threadname>',threadcategori=threadcategori,threadname=threadname)

@route('/<threadcategori>/thread/<threadname>')
def lookatsinglethread(threadcategori,threadname):
    singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    return template("singlethread2", threadname=threadname, threadtext=threadtext, commentlist=commentlist)

@route('/threadoverview/<threadcategori>')
def threadoverview(threadcategori):
    threadlist = os.walk('static/threads/{0}'.format(threadcategori)).next()[1]
    return template("threadoverview", threads=threadlist, threadcategori=threadcategori)

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

@route('/savenewthread/<threadcategori>', method="POST")
def savethread(threadcategori):
    title = request.forms.get("title").replace(" ", "_____")
    text = request.forms.get("text")
    newpath2 = r'static/threads/{1}/{0}'.format(title, threadcategori)
    newpath = r'static/threads/{1}/{0}/comments'.format(title, threadcategori) 
    if not os.path.exists(newpath):
        os.makedirs(newpath)

    newthreadtitlefile = open("{0}/tstitle.txt".format(newpath2), "w")
    newthreadtitlefile.write(title)
    newthreadtitlefile.close()

    newthreadtextfile = open("{0}/tstext.txt".format(newpath2), "w")
    newthreadtextfile.write(text)
    newthreadtextfile.close()
    #redirect('/lootatsinglethread/<threadname>',threadname )
    return template("singlethread", tspath=newpath2)

@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static')

run(host='localhost', port=9142, debug=True, reloader=True)

