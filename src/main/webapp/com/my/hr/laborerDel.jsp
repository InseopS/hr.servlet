<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
    // 노동자 삭제
    
        if(isVal($('#laborerId:checked'))) {
            $('#modalMsg').text('노동자를 삭제하시겠습니까?')
            $('#modalBtn').show()
            $('#modal').modal()
        }


       let laborerId = $('#laborerId:checked').val()

       $.each(laborers, (i, laborer) => {
           if(laborer.laborerId == laborerId) {
               laborers.splice(i, 1)
               return false
           }
       })

