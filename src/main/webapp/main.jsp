<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
<%@ page import='com.my.hr.domain.Laborer' %>
<%@ page import='com.my.hr.service.*' %>
<%@ page import='java.time.*' %>
<%@ page import='java.util.*' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%
	LaborerService laborerService = new LaborerServiceImpl();
%>
<head>
    <title>HR</title>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js'></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
    <link rel='stylesheet' href='http://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
    <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css' />
<script>

function isVal(field) {
    let isGood = false
    let errMsg

    if(!field.length) errMsg = '노동자를 선택하세요.'
    else {
        if(!field.val()) errMsg = field.attr('placeholder') + ' 입력하세요.'
        else isGood = true
    }

    if(!isGood) {
        $('#modalMsg').text(errMsg).css('color', 'red')
        $('#modalBtn').hide()
        $('#modal').modal()
    }

    return isGood
}

function listLaborers() {
   $('input').not(':radio').val('') // input에 radio가 없는 것들의 값을 ''로 초기화
   $('#laborers').empty()
   const laborerArr = []
<%	
	List<Laborer> laborersTmp = laborerService.getLaborers();
   String[] arrTmp;
   String strTmp = "";
   
   if(laborersTmp.size() != 0) {
	   for(int i = laborersTmp.size(); i > 0; i--) {
		   strTmp = laborersTmp.get(i-1).toString();
		   arrTmp = strTmp.split(" ");
%>
			laborerArr.push(
	         `<tr>
	             <td><input type='radio' name='laborerId' id='laborerId'
	                     value='<%= arrTmp[0] %>'/></td>
	             <td><%= arrTmp[0] %></td>
	             <td><%= arrTmp[1] %></td>
	             <td><%= arrTmp[2] %></td>
	         </tr>`
         )
<%
   	}
%>
	   $('#laborers').append(laborerArr.join(''))
<%
   } else {
%>
		$('#laborers').append(
		
		 	'<tr><td colspan=4 class=text-center>노동자가 없습니다.</td></tr>')
<%
   }
%>
}

function init() {
	$('#addLaborerBtn').click(() => {
		if(isVal($('#laborerName')) && isVal($('#hireDate'))) {
			$.ajax({
				type:'POST',
				url:'com/my/hr/laborerAddProc.jsp',
				data:{
					laborerName: $('#laborerName').val(),
					hireDate: $('#hireDate').val()
				},
				success:function(data) {
					location.href="main.jsp"
				}
			})
		}		
	})
    
   $('#fixLaborerBtn').click(() => {
		if(isVal($('#laborerId:checked')) &&
			isVal($('#laborerName')) && isVal($('#hireDate'))) {
			$.ajax({
				type:'POST',
				url:'com/my/hr/laborerFixProc.jsp',
				data:{
					laborerId: $('#laborerId:checked').val(),
					laborerName: $('#laborerName').val(),
					hireDate: $('#hireDate').val()
				},
				success:function(data) {
					location.href="main.jsp"
				}
			})
		}
	})
   
   $('#delLaborerBtn').click(() => {
        if(isVal($('#laborerId:checked'))) {
            $('#modalMsg').text('노동자를 삭제하시겠습니까?')
            $('#modalBtn').show()
            $('#modal').modal()
        }
    })

	$('#delLaborerOkBtn').click(() => {
		$.ajax({
			type:'POST',
			url:'com/my/hr/laborerDelProc.jsp',
			data:{
				laborerId: $('#laborerId:checked').val()
			},
			success:function(data) {
				$('#modal').modal('hide')
				location.href="main.jsp"
			}
		});
	})
   
	$('#laborers').on({
		change() {
			$('#laborerName').val($(this).parent().next().next().text())
			$('#hireDate').val($(this).parent().next().next().next().text())
   	}
	}, '#laborerId')
}

$(listLaborers)
$(init)

</script>
<style>
#hireDate::before {
    content: attr(placeholder);
    width: 100%;
}

#hireDate:focus::before, #hireDate:valid::before {
    display: none;
}
</style>
</head>

<div class='container'>
    <div class='row'>
        <div class='col'>
            <header class='jumbotron p-2'>
                <h1 class='text-center'>HR</h1>
            </header>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <form>
                <div class='row mb-3'>
                    <div class='col-2'>
                        <input type='text' class='form-control' placeholder='노동자명' id='laborerName'/>
                    </div>
                    <div class='col-4'>
                        <input type='date' class='form-control' placeholder='입사일' id='hireDate' required/>
                    </div>
                    <div class='col'>
                        <nav class='d-flex'>
                            <button type='button' class='btn btn-success flex-fill mr-1' id='addLaborerBtn'>
                                <i class='fas fa-plus'></i>
                                <sapn class='label d-none d-sm-inline'>추가</sapn>
                            </button>
                            <button type='button' class='btn btn-info flex-fill mr-1' id='fixLaborerBtn'>
                                <i class='fas fa-edit'></i><span class='label d-none d-sm-inline'>수정</span>
                            </button>
                            <button type='button' class='btn btn-warning flex-fill' id='delLaborerBtn'>
                                <i class='fas fa-trash-alt'></i><span class='label d-none d-sm-inline'>삭제</span>
                            </button>
                        </nav>
                    </div>
                </div>
                <div class='row'>
                    <div class='col'>
                        <table class='table'>
                            <thead>
                                <tr><th></th><th>ID</th><th>이름</th><th>입사일</th></tr>
                            </thead>
                            <tbody id='laborers'>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class='modal fade' tabindex='-1' id='modal'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal'>
                    <span>&times;</span>
                </button>
            </div>
            <div class='modal-body'>
                <p id='modalMsg'></p>
            </div>
            <div class='modal-footer' id='modalBtn'>
                <button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
                <button type='button' class='btn btn-primary' id='delLaborerOkBtn'>예</button>
            </div>
        </div>
    </div>
</div>