
var keynum, lines = 1;

      function limitLines(obj, e) {
        // IE
        if(window.event) {
          keynum = e.keyCode;
        // Netscape/Firefox/Opera
        } else if(e.which) {
          keynum = e.which;
        }

        if(keynum == 13) {
          if(lines == obj.rows) {
            return false;
          }else{
            lines++;
          }
        }
      }



function showReplyBox(id,topicid,thispage,asd)


  {
      if (asd==0) {
     var elem = '<form id ="form1" action = "'+formLink+'" enctype="multipart/form-data" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<a id ="jsclose" href="javascript:void(0)" onclick="showReplyBox(44,142,1);">Close</a><textarea name="text" placeholder="Comment" maxlength="1000" rows="5" cols="50"></textarea><hr><input id="jsaddfile" type="file" name="commentimg" accept="image/*"><input id="jsaddcomment" type="submit" value="Submit"></form>';

    var empty = "";  

    $("#elem").animate({'left':'300','opacity':'0'}, 0, function(){

    $(this).css({'left':'30%','opacity':'1'});
    $(this).css({'top':'10%','opacity':'1'});


});
          document.getElementById('elem').innerHTML = elem;
return false;
    }
      else { 
    document.getElementById('elem').innerHTML = null;
return false;
}
      
}

function showReplyBox2(id,topicid,thispage,asd,currentElement)


  {
      if (asd==0) {
     var mapp = currentElement.getAttribute("data-form-link");
        console.log(mapp);
    
var elem = '<form id ="form1" action = "'+mapp+'" enctype="multipart/form-data" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<a id ="jsclose" href="javascript:void(0)" onclick="showReplyBox(44,142,1);">Close</a><textarea name="text" placeholder="Comment" maxlength="1000" rows="5" cols="50"></textarea><hr><input id="jsaddfile" type="file" name="commentcommentimg" accept="image/*"><input id="jsaddcomment" type="submit" value="Submit"></form>';
    var empty = ""; 

    $("#elem").animate({'left':'300','opacity':'0'}, 0, function(){

    $(this).css({'left':'30%','opacity':'1'});
    $(this).css({'top':'10%','opacity':'1'});


});
          document.getElementById('elem').innerHTML = elem;
return false;
    }
      else { 
    document.getElementById('elem').innerHTML = null;
return false;
}
      
}

  $(function() {
   $( "#mydiv_to_make_draggable" ).draggable();
   });

  $(function() {
    $( "#elem" ).draggable();
  });

    $( ".selector" ).draggable({
  containment: "parent"
});

// Getter
var containment = $( ".selector" ).draggable( "option", "containment" );
 
// Setter
$( ".selector" ).draggable( "option", "containment", "parent" );

function goBack() {
    window.history.back();
}