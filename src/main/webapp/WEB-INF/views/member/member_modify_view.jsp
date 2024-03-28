<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="UTF-8">
	<title>바라는 바다! :: 관리자 권한 회원 정보 수정</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
        $("#idcheck").click(function () {
            var id = $("#id").val();
            
         	// 아이디가 비어 있을 때 아이디 중복 검사를 할 경우
            if (id.trim() === "") {
                alert("아이디를 입력해주세요.");
                return;
            }

            $.ajax({
                type: "post",
                async: true,
                dataType: "text",
                url: "idcheck",
                data: {"id": id},
                success: function (result) {
                    if (result == "ok") {
                        alert("사용 가능한 아이디입니다.");
                    } 
                    else {
                        alert("중복된 아이디입니다.");
                    }
                },
                error: function () {
                    alert("오류가 발생했습니다.");
                }
            });
        });
        
        
	        $("#emailcheck").click(function () {
	            var email = $("#email").val();
	            
	         	// 이메일이 비어 있을 때 이메일 중복 검사를 할 경우
	            if (email.trim() === "") {
	                alert("이메일을 입력해주세요.");
	                return;
	            }
	
	            $.ajax({
	                type: "post",
	                async: true,
	                dataType: "text",
	                url: "emailcheck",
	                data: {"email": email},
	                success: function (result) {
	                    if (result == "ok") {
	                        alert("사용 가능한 이메일입니다.");
	                    } 
	                    else {
	                        alert("이미 가입된 이메일입니다.");
	                    }
	                },
	                error: function () {
	                    alert("오류가 발생했습니다.");
	                }
	            });
	        });
        

		    $("#submitBtn").click(function () {
		        var id = $("#id").val();
		        var pw = $("#pw").val();
		        var pw2 = $("#pw2").val();
		        var name = $("#name").val();
		        var email = $("#email").val();
		        var gender = $("input[name='gender']:checked").val();
		        var age = $("#age").val();
				var user_number = $("#user_number").val();
				
		        // 아이디 유효성 검사
		        var idPattern = /^[a-zA-Z0-9]{6,20}$/;
		        
		        if(!idPattern.test(id)) {
		            alert("아이디는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
		            return false;
		        }
		
		        // 패스워드 유효성 검사
		        var pwPattern = /^[a-zA-Z0-9]{6,20}$/;
		        if (!pwPattern.test(pw)) {
		            alert("비밀번호는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
		            return false;
		        }
		
		        // 패스워드 확인
		        if (pw != pw2) {
		            alert("비밀번호가 일치하지 않습니다.");
		            return false;
		        }
		        
		        // 이름 확인
		        var namePattern = /^[가-힣]{2,10}$/;
		        if(!namePattern.test(name)){
		        	alert("이름은 한글 2~10글자 이내여야 합니다.");
		        	return false;
		        }
		
		        // 이메일 유효성 검사
		        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		        if (!emailPattern.test(email)) {
		            alert("올바른 이메일 형식이 아닙니다.");
		            return false;
		        }
		        
		     	// 성별 선택 확인
		        if (!$("input[name='gender']").is(":checked")) {
		            alert("성별을 선택해주세요.");
		            return false;
		        }

		        // 연령대 선택 확인
		        if ($("#age").val() == "") {
		            alert("연령대를 선택해주세요.");
		            return false;
		        }
		
		        // 모든 조건 통과 시 폼 제출
		        $.ajax({
		            type: "post",
		            url: "member_modify",
		            data: {
		            	user_number : user_number,
		                id: id,
		                pw: pw,
		                name: name,
		                email: email,
		                gender: gender,
		                age: age
		            },
		            success: function (response) {
		                // 저장이 성공적으로 이루어졌을 때 알럿창을 띄움
		            	alert("회원수정이 완료되었습니다.");
		            	alert('메인화면으로 이동합니다.');
	            		window.location.href='main';
		            },
		            error: function () {
		                alert("오류가 발생했습니다.");
		            }
		        });
		
		    });
		});
    </script>
</head>
<body>

<c:choose>
	<c:when test="${loginstate==true && position=='admin'}">

	<div style="text-align: center;">
	  <form action="member_modify" method="post">
		<c:forEach items="${list}" var="li">
		  <input type="hidden" name="user_number" id="user_number" value="${li.user_number}">
	      <table border="1" width="600" align="center">
	        <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="id" id="id" value="${li.id}" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
                	<input type="button" value="중복 확인" id="idcheck">
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="pw" value="${li.pw}" id="pw" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
                </td>
            </tr>
            <tr>
                <th>비밀번호 확인</th>
                <td>
                    <input type="password" id="pw2" placeholder="비밀번호를 한 번 더 써주세요." required>
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" id="name" value="${li.name}" placeholder="이름을 입력해주세요." required>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" id="email" value="${li.email}" placeholder="이메일을 ----@--.- 형식으로 입력해주세요." required>
                </td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <input type="radio" name="gender" value="male" required <c:if test="${li.gender eq male}">checked</c:if>> 남성
                    <input type="radio" name="gender" value="female" required <c:if test="${li.gender eq female}">checked</c:if>> 여성
                    <input type="radio" name="gender" value="other" required <c:if test="${li.gender eq other}">checked</c:if>> 밝히고 싶지 않음(기타)
                </td>
            </tr>
			<tr>
			    <th>연령대</th>
			    <td>
			        <select id="age" name="age" required>
			            <option value="">나이대를 선택해주세요.</option>
			            <option value="10" <c:if test="${li.age eq 10}">selected</c:if>>10대 이하</option>
			            <option value="20" <c:if test="${li.age eq 20}">selected</c:if>>20대</option>
			            <option value="30" <c:if test="${li.age eq 30}">selected</c:if>>30대</option>
			            <option value="40" <c:if test="${li.age eq 40}">selected</c:if>>40대</option>
			            <option value="50" <c:if test="${li.age eq 50}">selected</c:if>>50대</option>
			            <option value="60" <c:if test="${li.age eq 60}">selected</c:if>>60대 이상</option>
			        </select>
			    </td>
			</tr>

            <tr>
            	<td colspan="2" align="center">
	            	<input type="button" value="수정하기" id="submitBtn">
					<input type="reset" value="처음으로">
            	</td>
            </tr>	        	                     	        
	    </table>
	    </c:forEach>
	  </form>  
	</div>

    <div style="text-align: center;"><a href="member_out">목록으로</a></div>
    
    </c:when>
    
    <c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("관리자 외 접근할 수 없는 페이지 입니다.");
			    window.location.href = "${pageContext.request.contextPath}/main";
			};
	    </script>
	    
	</c:otherwise>
</c:choose>

</body>
</html>