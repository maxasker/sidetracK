function showReplyBox(id,topicid,thispage,asd){
    if (asd==0) {
    
var elem = '<form id ="form1" action = "'+formLink+'" enctype="multipart/form-data" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<textarea name="text" placeholder="Title" maxlength="100" rows="5" cols="50">Title</textarea><hr><hr><input type="file" name="commentimg" accept="image/*"><input type="submit" value="Spara innehåll"></form>';
    var empty = ""; 
        
$("#elem").animate({'left':'300','opacity':'0'}, 0, function(){

    $(this).css({'left':'0','opacity':'1'});
});

document.getElementById('elem').innerHTML = elem;
return false;

}
        else { 
    document.getElementById('elem').innerHTML = null;
return false;
}

}

function showReplyBox2(id,topicid,thispage,asd, currentElement){
    if (asd==0) {
        
    var mapp = currentElement.getAttribute("data-form-link");
        console.log(mapp);
    
var elem = '<form id ="form1" action = "'+mapp+'" enctype="multipart/form-data" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<textarea name="text" placeholder="Title" maxlength="100" rows="5" cols="50">Title</textarea><hr><hr><input type="file" name="commentcommentimg" accept="image/*"><input type="submit" value="Spara innehåll"></form>';
    var empty = ""; 
        
$("#elem").animate({'left':'300','opacity':'0'}, 0, function(){

    $(this).css({'left':'0','opacity':'1'});
    
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