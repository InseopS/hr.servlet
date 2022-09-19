<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8' %>
    // 노동자 수정

        if(isVal($('#laborerId:checked')) &&
            isVal($('#laborerName')) && isVal($('#hireDate'))) {
                let laborerId = $('#laborerId:checked').val()

                $.each(laborers, (i, laborer) => {
                    if(laborer.laborerId == laborerId) {
                        laborer.name = $('#laborerName').val()
                        laborer.hireDate = $('#hireDate').val()
                        return false
                    }
                })

                
            }
