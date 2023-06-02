fetch('getComen.php')
    .then(res => res.json())
    .then(data => {
        //console.log(data);
        var total = 8;
        let str = '';
        str += '<div class="row row-cols-1 row-cols-md-4 g-4 justify-content-center">'
        data.map(item => {
            if(total>0){
                total = total - 1;
            
                var icono = '';
                if(item.calificacion == 1)
                    icono='<i class="fa-solid fa-face-angry fa-2xl" style="color: #da1616;"></i>';
                else if(item.calificacion == 2)
                    icono='<i class="fa-solid fa-face-frown fa-2xl" style="color: #ec9822;"></i>';
                else if(item.calificacion == 3)
                    icono='<i class="fa-solid fa-face-meh fa-2xl" style="color: #d3cd16;"></i>';
                else if(item.calificacion == 4)
                    icono='<i class="fa-solid fa-face-smile fa-2xl" style="color: #1adb30;"></i>';
                else if(item.calificacion == 5)
                    icono='<i class="fa-solid fa-face-grin-stars fa-2xl" style="color: #26bf08;"></i>';
                
                str += 
                '<div class="col">'+
                    '<div class="card h-100" data-aos="flip-left" data-aos-duration="3000">'+
                        '<div class="card-header">'+
                            '<h2 class="card-title" style="text-align: center;">'+item.nombre+'</h2>'+
                        '</div>'+
                        '<div class="card-body">'+
                            '<p class="card-text">'+item.mensaje+'</p>'+
                        '</div>'+
                        '<div class="card-footer">'+
                            '<h6 style="text-align: right;">'+icono+item.fecha+'</h6>'+
                        '</div>'+
                    '</div>'+
                '</div>'
            }
        });
        str += '</div>'
        var currentDiv = document.getElementById("divComen");
        currentDiv.innerHTML = str;
    });