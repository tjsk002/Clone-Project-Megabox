function btnAllCheck(){
    if($("#buttonAll").is(':checked')){
    	$("input[type=checkbox]").prop("checked", true);
    }else{
    	$("input[type=checkbox]").prop("checked", false);
    }
}

function checkForm(){
	if($('input:checkbox[name="btnCheck"]').eq(0).is(":checked") != true && $('input:checkbox[name="btnCheck"]').eq(0).is(":checked") != true){
		alert("필수사항을 선택해주세요.");
		return false;
	}
	return true;
}

/*function checkForm(){
	if($('input:checkbox[name="btnCheck"]').eq(0).is(":checked") != true && $('input:checkbox[name="btnCheck"]').eq(0).is(":checked") != true){
		alert("필수사항을 선택해주세요.");
		return false;
	}
	return true;
}
*/


/*
function allCheckFunc( obj ) {
    $("[name=btnCheck]").prop("checked", $(obj).prop("checked") );
}

체크박스 체크시 전체선택 체크 여부 
function oneCheckFunc( obj )
{
var allObj = $("[name=checkAll]");
var objName = $(obj).attr("name");

if( $(obj).prop("checked") )
{
    checkBoxLength = $("[name="+ objName +"]").length;
    checkedLength = $("[name="+ objName +"]:checked").length;

    if( checkBoxLength == checkedLength ) {
        allObj.prop("checked", true);
    } else {
        allObj.prop("checked", false);
    }
}
else
{
    allObj.prop("checked", false);
}
}

$(function(){
$("[name=checkAll]").click(function(){
    allCheckFunc( this );
});
$("[name=btnCheck]").each(function(){
    $(this).click(function(){
        oneCheckFunc( $(this) );
    });
});
});
*/
