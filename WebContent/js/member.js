function member(){
	var nameCheck = RegExp(/^[가-힣]+$/);
	var birthCheck = RegExp(/^\d{6}$/);
	var hpCheck = RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
    var idCheck = RegExp(/^[a-zA-Z0-9]{8,12}$/);
    var pwCheck = RegExp(/^.*(?=^.{10,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/);
    var emailCheck = RegExp(/^[A-Za-z0-9+\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
    
    if(!nameCheck.test($("#username").val())){
        alert("이름은 한글로 입력하세요.");
        $("#username").val("");
        $("#username").focus();
        return false;
    }
    if(!birthCheck.test($("#ssn1").val())){
    	alert("생년월일은 6자리만 입력해주세요.");
    	$("#ssn1").val("");
    	$("#ssn1").focus();
    	return false;
    }
    if(!hpCheck.test($("#hp").val())){
        alert("휴대폰 형식에 맞게 입력하세요.");
        $("#hp").val("");
        $("#hp").focus();
        return false;
    }
    
    if(!idCheck.test($("#userid").val())){
        alert("아이디를 형식에 맞게 입력하세요.");
        $("#userid").val("");
        $("#userid").focus();
        return false;
    }
    if(!pwCheck.test($("#userpw").val())){
        alert("비밀번호를 형식에 맞게 입력하세요(10자 이상)");
        $("#userpw").val("");
        $("#userpw").focus();
        return false;
    }
    if($("#userpw").val() != $("#userpw_re").val()){
        alert("비밀번호가 서로 다릅니다.")
        $("#userpw").val("");
        $("#userpw_re").val("");
        $("#userpw").focus();
        return false;
    }
    
    if(!emailCheck.test($("#email").val())){
        alert("이메일 형식에 맞게 입력하세요.");
        $("#email").val("");
        $("#email").focus();
        return false;
    }
    
    return true;
}