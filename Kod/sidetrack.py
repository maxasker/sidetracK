#!/usr/bin/env python
# -*- coding: utf-8 -*-
from bottle import run, route, template, request, static_file, get, post, error
from bottle import static_file
from bottle import url
from bottle import redirect
import os
import sys
import datetime
import re
import smtplib
from socket import gethostname, gethostbyname
global threadlistlike
global threadlistclassified
global threadlistdislike
#skapar listor för trådhanteringen
threadlistlike = []
threadlistclassified = []
threadlistdislike = []

@route('/reportts/<threadname>')
def reportts(threadname):
    mail = smtplib.SMTP('smtp.gmail.com',587)
    mail.ehlo()
    mail.starttls()
    mail.login('sidetrack.inc@gmail.com','githubsucks123')
    mail.sendmail('sidetrack.inc@gmail.com','sidetrack.inc@gmail.com',"report "+threadname)
    mail.close()
    errorvar = "Thank you for the report, we will investigare this further!"
    return template('error',errorvar=errorvar)

@route('/sendfeedback', method="POST")
def sendfeedback():
    feedbacktext = request.forms.get("feedbacktext")
    feedbacksender = request.forms.get("sender")
    if feedbacksender is None:
        feedbacksender = "anonymous"
    if feedbacktext == "":
        errorvar = "You missed a field!"
    else:
        mail = smtplib.SMTP('smtp.gmail.com',587)
        mail.ehlo()
        mail.starttls()
        feedbacktext = feedbacktext + " sent from " + feedbacksender
        mail.login('sidetrack.inc@gmail.com','githubsucks123')
        mail.sendmail('sidetrack.inc@gmail.com','sidetrack.inc@gmail.com',feedbacktext)
        mail.close()
        errorvar = "Thank you for your feedback!"
    return template('error',errorvar=errorvar)

@route('/')
def index():
    '''
        Startsidan, returnerar index.tpl
    '''
    return template("index")

@route('/homepage')
def homepage():
    '''
        Redirect till startsidan när man trycker på loggan.
    '''
    redirect('/')

@route('/<threadcategori>/createthread')
def threadshow(threadcategori):
    '''
        Knappen "Skapa tråd på threadoverview" Den skickar vidare vilken kategori man är inne på så att tråden sparas korrekt och returnerar savethread.
    '''
    threadcategori = threadcategori
    return template("savenewthread", threadcategori=threadcategori)

@route('/<threadcategori>/thread/<threadname>')
def lookatsinglethread(threadcategori,threadname):
    '''
        funktionen för att titta på en tråd (singlethread2.tpl), den tar emot trådkategorin och trådnamnet för att kunna hitta rätt mappar
    '''
    #öppnar trådens tstext och tsinfo och tar ut informationen i variablerna threadtext och threadinfo där infon är tid och datum
    singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    singlethreadinfo = open("static/threads/{1}/{0}/tsinfo.txt".format(threadname,threadcategori), "r")
    threadinfo = singlethreadinfo.read()
    singlethreadinfo.close()
    #gör en lista av mapparna i kommentarsmappen
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    #sorterar listan
    sorted(commentlist)
    filelist2 = []
    for mapp in commentlist:
        files = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
        addfilelist = [i for i in files if i.endswith('.txt')]
        filelist2= filelist2 + addfilelist
    commentcounter2 = len(filelist2)
    #gör en lista över innehållet i trådmappen för att hitta ts-bilden och loopar sedan ut bild och lägger den i tsimg-variabeln
    myList = os.listdir('static/threads/{1}/{0}/'.format(threadname,threadcategori))
    for myFile in myList:
        if re.match("tsimg.png", myFile):
            tsimg = myFile
        elif re.match("tsimg.jpeg", myFile):
            tsimg = myFile
        elif re.match("tsimg.jpg", myFile):
            tsimg = myFile
        elif re.match("tsimg.gif", myFile):
            tsimg = myFile
    #gör hela pathen med bilden
    tsimgpath = ('static/threads/{0}/{1}/{2}'.format(threadcategori,threadname,tsimg))
    #returnar singlethread2 och skickar med variabler
    return template("singlethread2",commentcounter2=commentcounter2,tsimg=tsimg,tsimgpath=tsimgpath, threadname=threadname, threadtext=threadtext, commentlist=commentlist,threadcategori=threadcategori,threadinfo=threadinfo)

    
@route('/threadoverview/<threadcategori>/<page>')
def threadoverview(threadcategori,page):
    '''
        trådöverblicken, den tar emot trådkategorin och vilken sida man är på som representeras i page
    '''
    #räknar ut vilken page man är på och ger mini och maxi värde
    mini=int(page)*10-10
    maxi=int(page)*10
    #tar ut vissa items i listan beroende på vilken page man är på, tex 0:10 och beroende på vilken kategori man är på
    if threadcategori == "like":
        threadlist2 = threadlistlike[mini:maxi]
        threadlisttest = threadlistlike
    elif threadcategori == "classified":
        threadlist2 = threadlistclassified[mini:maxi]
        threadlisttest = threadlistclassified
    elif threadcategori == "dislike":
        threadlist2 = threadlistdislike[mini:maxi]
        threadlisttest = threadlistdislike
    #returnerar threadoverview och skickar med threadlist2 och kategorin
    return template("threadoverview", threads=threadlist2, threadcategori=threadcategori, page=page,threadlisttest=threadlisttest)

@route('/<threadcategori>/<threadname>/savenewcomment', method="POST")
def savenewcomment(threadcategori,threadname):
    '''
        funktionen för att spara en orginalkommentar
    '''
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    filelist3 = []
    for mapp in commentlist:
        files = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
        addfilelist = [i for i in files if i.endswith('.txt')]
        filelist3= filelist3 + addfilelist
    if len(filelist3) > 200:
        redirect('/errorlimit')
    #tar bilden ifrån formuläret
    upload = request.files.get("commentimg")
    #om upload finns
    if upload is not None:
        #den splittar extentionen och säger till om fileext är ogiltig
        name, ext = os.path.splitext(upload.filename)
        #kollar så att ext är giltig
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            redirect('/errorext')
    #räknare för att kontrollera vilken kommentar som skall sparas
    counter = 1
    #gör en path med comment1 i slutet
    newpath2 = r'static/threads/{0}/{1}/comments/comment{2}'.format(threadcategori,threadname,counter)
    #kör funktionen som kollar om mappen finns
    checkifdirexists(newpath2,counter,threadname,threadcategori)
    #tar ut texten som har skrivits i formuläret
    commenttext = request.forms.get("text")
    commenttext = checklangcomment(commenttext)
    #gör en ny path för att spara kommentaren
    newpath = r'static/threads/{0}/{1}/comments/comment{2}/comment1.txt'.format(threadcategori,threadname,counter)
    #kollar om den redan finns
    checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    #redirectar till samma singlethread igen
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/<mapp>/savenewcommentcomment', method="POST")
def savenewcommentcomment(threadcategori,threadname,mapp):
    '''
        Funktionen för att spara svar-på-svar, den tar emot kategori/namn och sen vilken mapp man är inne i
    '''
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    filelist3 = []
    for mappar in commentlist:
        files = os.listdir("static/threads/{0}/{1}/comments/{2}/".format(threadcategori,threadname,mapp))
        addfilelist = [i for i in files if i.endswith('.txt')]
        filelist3= filelist3 + addfilelist
    if len(filelist3) > 200:
        redirect('/errorlimit')
    upload = request.files.get("commentcommentimg")
    #om upload finns så splitta namn och text och kontrollera ext
    if upload is not None:
        name, ext = os.path.splitext(upload.filename)
        #kollar så att ext är giltig
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            redirect('/errorext')
    #räknaren är på 2 iom att detta inte kan vara en originalkommentar, mao comment1.txt är en originalkommentar
    counter = 2
    #skapar en path med comment2.txt
    newpath = r'static/threads/{0}/{1}/comments/{2}/comment{3}.txt'.format(threadcategori,threadname,mapp,counter)
    #tar ut texten ifrån formuläret
    commenttext = request.forms.get("text")
    commenttext = checklangcomment(commenttext)
    #kör funktionen som kollar om den finns eller inte som till slut sparar kommentaren
    checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp)
    #redirectar till samma tråd igen
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

def createcommentimg(threadcategori,threadname,counter):
    '''
        Funktion för att spara bild på orginalkommentar
    '''
    #tar bilden ifrån formuläret
    upload = request.files.get("commentimg")
    #om upload finns
    if upload is not None:
        #den splittar extentionen och säger till om fileext är ogiltig
        name, ext = os.path.splitext(upload.filename)
        #kollar så att ext är giltig
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            return "File extension not allowed."
        extt = str(ext)
        #sparar bilden
        file_path = 'static/threads/{0}/{1}/comments/comment{2}/comment1{3}'.format(threadcategori,threadname,counter,extt)
        with open(file_path, 'wb') as open_file:
            open_file.write(upload.file.read())

def createcommentcommentimg(threadcategori,threadname,mapp,counter):
    '''
        Kollar om det finns en upload av bild och sparar den
    '''
    upload = request.files.get("commentcommentimg")
    #om upload finns så splitta namn och text och spara den som commentX.ext
    if upload is not None:
        name, ext = os.path.splitext(upload.filename)
        #kollar så att ext är giltig
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            return "File extension not allowed."
        extt = str(ext)
        file_path = 'static/threads/{0}/{1}/comments/{2}/comment{3}{4}'.format(threadcategori,threadname,mapp,counter,extt)
        with open(file_path, 'wb') as open_file:
            open_file.write(upload.file.read())

def checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp):
    '''
        Kollar om comment2.txt finns i den mappen, om den finns så ökar till 3.txt etc tills den hittar en ledig och sen nästa funktion
    '''
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/{0}/{1}/comments/{2}/comment{3}.txt'.format(threadcategori,threadname,mapp,counter)
        checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp)
    else:
        createcommentcommentfile(commenttext,threadname,newpath,counter,threadcategori,mapp)

def checkifdirexists(newpath2,counter,threadname,threadcategori):
    '''
        Kollar om mappen finns, gör den inte det så ökar den slutsiffran och kör om funktionen till den hittar en ledig plats
    '''
    if not os.path.exists(newpath2):
        os.makedirs(newpath2)
    else:
        counter = counter+1
        newpath2 = r'static/threads/{0}/{1}/comments/comment{2}'.format(threadcategori,threadname,counter)
        checkifdirexists(newpath2,counter,threadname,threadcategori)

def checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori):
    '''
        Kollar om filen finns, om den gör det så ökar den countern och kör om funktionen, tar med argument för att skicka vidare dem i funktionerna
    '''
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/{0}/{1}/comments/comment{2}/comment1.txt'.format(threadcategori,threadname,counter)
        checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    else:
        #kör funktionen createcommentfile för att skapar filen
        createcommentfile(commenttext,threadname,newpath,counter,threadcategori)

def createcommentcommentfile(commenttext,threadname,newpath,counter,threadcategori,mapp):
    '''
        tar emot commenttext, path och kategori för denna funktionen och resten till nästa
    '''
    #öppnar ny fil
    newcommentfile = open("{0}".format(newpath), "w")
    #skriver in datum och tid och sen commenttexten på andra raden
    date_time = datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S")
    newcommentfile.write(date_time)
    newcommentfile.write("\n"+commenttext)
    newcommentfile.close()
    #kollar vilken kategori vi är på och flyttar upp tråden till först i listan
    if threadcategori == "like":
        threadlistlike.remove(threadname)
        threadlistlike.insert(0, threadname)
    elif threadcategori == "classified":
        threadlistclassified.remove(threadname)
        threadlistclassified.insert(0, threadname)
    elif threadcategori == "dislike":
        threadlistdislike.remove(threadname)
        threadlistdislike.insert(0, threadname)
    #startar funktionen som sparar eventuell bild
    createcommentcommentimg(threadcategori,threadname,mapp,counter)

def createcommentfile(commenttext,threadname,newpath,counter,threadcategori):
    '''
        Skapar kommentarsfilen och kör sedan createcommentimg för att skapa bilden
    '''
    #öppnar pathen och filen
    newcommentfile = open("{0}".format(newpath), "w")
    #tar ut tiden
    date_time = datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S")
    #skriver in tiden först i dokumentet
    newcommentfile.write(date_time)
    newcommentfile.write("\n"+commenttext)
    newcommentfile.close()
    #kollar vilken kategori den är inne på och lägger den först i listan
    if threadcategori == "like":
        threadlistlike.remove(threadname)
        threadlistlike.insert(0, threadname)
    elif threadcategori == "classified":
        threadlistclassified.remove(threadname)
        threadlistclassified.insert(0, threadname)
    elif threadcategori == "dislike":
        threadlistdislike.remove(threadname)
        threadlistdislike.insert(0, threadname)
    #kör funktionen för att skapa bilden som kanske laddats upp
    createcommentimg(threadcategori,threadname,counter)

def checklangcomment(commenttext):
    text2 = commenttext
    commenttext = ""
    for word in text2.split():
        if word.lower() == "nigger":
            word = word.lower()
            word = word.replace("nigger","individual of african descent")
        elif word.lower() == "cunt":
            word = word.lower()
            word = word.replace("cunt","my vocabulary sucks")
        elif word.lower() == "whore":
            word = word.lower()
            word = word.replace("whore","lady")
        elif word.lower() == "max":
            word = word.lower()
            word = word.replace("max","our lord and savior")
        elif word.lower() == "faggot":
            word = word.lower()
            word = word.replace("faggot","homosexual")
        elif word.lower() == "dyke":
            word = word.lower()
            word = word.replace("dyke","homosexual")
        elif word.lower() == "chink":
            word = word.lower()
            word = word.replace("chink","individual of asian descent")
        commenttext = commenttext + word + " "
    return commenttext

def checklangts(text):
    text2 = text
    text = ""
    for word in text2.split():
        if word.lower() == "nigger":
            word = word.lower()
            word = word.replace("nigger","individual of african descent")
        elif word.lower() == "cunt":
            word = word.lower()
            word = word.replace("cunt","my vocabulary sucks")
        elif word.lower() == "whore":
            word = word.lower()
            word = word.replace("whore","lady")
        elif word.lower() == "max":
            word = word.lower()
            word = word.replace("max","our lord and savior")
        elif word.lower() == "faggot":
            word = word.lower()
            word = word.replace("faggot","homosexual")
        elif word.lower() == "dyke":
            word = word.lower()
            word = word.replace("dyke","homosexual")
        elif word.lower() == "chink":
            word = word.lower()
            word = word.replace("chink","individual of asian descent")
        text = text + word + " "
    return text

def checklangtitle(threadname):
    text2 = threadname
    threadname = ""
    for word in text2.split():
        if word.lower() == "nigger":
            word = word.lower()
            word = word.replace("nigger","individual of african descent")
        elif word.lower() == "cunt":
            word = word.lower()
            word = word.replace("cunt","my vocabulary sucks")
        elif word.lower() == "whore":
            word = word.lower()
            word = word.replace("whore","lady")
        elif word.lower() == "max":
            word = word.lower()
            word = word.replace("max","our lord and savior")
        elif word.lower() == "faggot":
            word = word.lower()
            word = word.replace("faggot","homosexual")
        elif word.lower() == "dyke":
            word = word.lower()
            word = word.replace("dyke","homosexual")
        elif word.lower() == "chink":
            word = word.lower()
            word = word.replace("chink","individual of asian descent")
        threadname = threadname + word + " "
    return threadname

@route('/savenewthread/<threadcategori>', method="POST")
def savethread(threadcategori):
    '''
        Sparar tråd och tar informationen ifrån formuläret på createthread.tpl
    '''
    #tar bilden och sparar den i en variabel
    upload = request.files.get("tspic")
    #om det inte laddas upp en bild så nekar den och avbryter
    if request.files.get("tspic") is None:
        redirect('/errorimg')
    #nekar om ext inte är giltig
    name, ext = os.path.splitext(upload.filename)
    if ext not in ('.png','.jpg','.jpeg','.gif'):
        redirect('/errorext')
    ip = gethostbyname(gethostname())
    #tar titlen och sparar den
    threadname = request.forms.get("title")
    threadname = checklangtitle(threadname)
    threadname = threadname.replace(" ", "_____")
    threadname = threadname + str(ip)
    #tar texten och sparar den
    text = request.forms.get("text")
    text = checklangts(text)
    #skapar 2 paths, en för commentmappen i trådmappen och en för förstainstansen i trådmappen
    newpath = r'static/threads/{1}/{0}/comments'.format(threadname, threadcategori)
    newpath2 = r'static/threads/{1}/{0}'.format(threadname, threadcategori)
    #om pathen för trådmappen finns så nekar den och avbryter
    if os.path.exists(newpath2):
        redirect('/errorthreadname')
    #sparar tid och datum
    date_time = datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S")
    #om trådmappen inte finns så skapas den
    if not os.path.exists(newpath):
        os.makedirs(newpath)
    #om det finns en upload så sparar den, extt är bara för att veta vilken extension det är
    if upload is not None:
        name, ext = os.path.splitext(upload.filename)
        #nekar om ext inte är giltig
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            redirect('/errorext')
        extt = str(ext)
        file_path = "{path}/{file}".format(path=newpath2, file="tsimg" + extt)
        with open(file_path, 'wb') as open_file:
            open_file.write(upload.file.read())
    #startar funktionen som sparar tråden och skickar med vilken path, trådnamn, trådtext och datumochtid
    savethreadfile(newpath2,threadname,text,date_time)
    #kollar vilken kategori tråden är i och lägger in tråden längst framme i listan, tar bort sista tråden om det är mer än 100
    if threadcategori == "like":
        threadlistlike.insert(0,threadname)
        if len(threadlistlike) > 100:
            #KOLLA HÄR !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            removed_item = threadlistlike.pop(-1)
    elif threadcategori == "classified":
        threadlistclassified.insert(0,threadname)
        if len(threadlistclassified) > 100:
            threadlistclassified.pop(-1)
    elif threadcategori == "dislike":
        threadlistdislike.insert(0,threadname)
        if len(threadlistdislike) > 100:
            threadlistdislike.pop(-1)
    #redirectar till den tråden man skapat
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

@route('/errorext')
def errorext():
    errorvar = "File extension not allowed."
    return template('error', errorvar=errorvar)

@route('/errorthreadname')
def errorextthreadname():
    errorvar = "Threadname already exists :("
    return template('error', errorvar=errorvar)

@route('/errorimg')
def errorimg():
    errorvar = "You need to upload a picture!"
    return template('error', errorvar=errorvar)

@route('/errorlimit')
def errorlimit():
    errorvar = "Comment-limit reached, thread closed."
    return template('error', errorvar=errorvar)

@route('/about')
def about():
    return template('about')

@route('/feedback')
def feedback():
    return template('feedback')

@error(404)
def error404(error):
    errorvar = "Nothing here, sorry"
    return template('error', errorvar = errorvar)

def savethreadfile(newpath2,threadname,text,date_time):
    #skapar tstitle.txt och skriver in trådnamnet, mao titeln
    newthreadtitlefile = open("{0}/tstitle.txt".format(newpath2), "w")
    newthreadtitlefile.write(threadname)
    newthreadtitlefile.close()
    #skapar tstext.txt och skriver in texten ifrån tråden
    newthreadtextfile = open("{0}/tstext.txt".format(newpath2), "w")
    newthreadtextfile.write(text)
    newthreadtextfile.close()
    #skapar tsinfo.txt och skriver in datum och tid
    newthreadtextfile = open("{0}/tsinfo.txt".format(newpath2), "w")
    newthreadtextfile.write(date_time)
    newthreadtextfile.close()


@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static')

run(host='localhost', port=9569, debug=True, reloader=True)
