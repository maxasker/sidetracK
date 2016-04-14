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
    lookatsinglethread(threadcategori,threadname)
    #redirect('/<threadcategori>/thread/<threadname>')

@route('/<threadcategori>/thread/<threadname>')
def lookatsinglethread(threadcategori,threadname):
    singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    return template("singlethread2", threadname=threadname, threadtext=threadtext, commentlist=commentlist,threadcategori=threadcategori)

def singlethread(threadcategori,threadname):
    singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    
@route('/threadoverview/<threadcategori>')
def threadoverview(threadcategori):
    threadlist = os.walk('static/threads/{0}'.format(threadcategori)).next()[1]
    return template("threadoverview", threads=threadlist, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/createnewcomment')
def createnewcomment(threadname,threadcategori):
    return template("commenttest", threadname=threadname, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/savenewcomment', method="POST")
def savenewcomment(threadcategori,threadname):
    counter = 1
    newpath2 = r'static/threads/{0}/{1}/comments/comment{2}'.format(threadcategori,threadname,counter)
    checkifdirexists(newpath2,counter,threadname,threadcategori)
    commenttext = request.forms.get("text")
    newpath = r'static/threads/{0}/{1}/comments/comment{2}/comment1.txt'.format(threadcategori,threadname,counter)
    checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/<mapp>/savenewcommentcomment', method="POST")
def savenewcommentcomment(threadcategori,threadname,mapp):
    counter = 2
    newpath = r'static/threads/{0}/{1}/comments/{2}/comment{3}.txt'.format(threadcategori,threadname,mapp,counter)
    commenttext = request.forms.get("text")
    checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp)
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

def checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp):
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/{0}/{1}/comments/{2}/comment{3}.txt'.format(threadcategori,threadname,mapp,counter)
        checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    else:
        createcommentfile(commenttext,threadname,newpath)

def checkifdirexists(newpath2,counter,threadname,threadcategori):
    if not os.path.exists(newpath2):
        os.makedirs(newpath2)
    else:
        counter = counter+1
        newpath2 = r'static/threads/{0}/{1}/comments/comment{2}'.format(threadcategori,threadname,counter)
        checkifdirexists(newpath2,counter,threadname,threadcategori)
    return counter

def checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori):
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/{0}/{1}/comments/comment{2}/comment1.txt'.format(threadcategori,threadname,counter)
        checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    else:
        createcommentfile(commenttext,threadname,newpath)

def createcommentfile(commenttext,threadname,newpath):
    newcommentfile = open("{0}".format(newpath), "w")
    newcommentfile.write(commenttext)
    newcommentfile.close()

@route('/savenewthread/<threadcategori>', method="POST")
def savethread(threadcategori):
    threadname = request.forms.get("title").replace(" ", "_____")
    text = request.forms.get("text")
    newpath2 = r'static/threads/{1}/{0}'.format(threadname, threadcategori)
    newpath = r'static/threads/{1}/{0}/comments'.format(threadname, threadcategori) 
    if not os.path.exists(newpath):
        os.makedirs(newpath)

    newthreadtitlefile = open("{0}/tstitle.txt".format(newpath2), "w")
    newthreadtitlefile.write(threadname)
    newthreadtitlefile.close()

    newthreadtextfile = open("{0}/tstext.txt".format(newpath2), "w")
    newthreadtextfile.write(text)
    newthreadtextfile.close()
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static')

run(host='localhost', port=9300, debug=True, reloader=True)

