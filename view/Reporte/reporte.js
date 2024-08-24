function init(){

}

$(document).ready(function(){
    
    $.post("../../controller/reporte.php?op=ticketabierto",function (data) {
        data = JSON.parse(data);

        var columns = data.map(function(item) {
            return [item.NombreTicket, item.TotalTickets];
        });

        var donutChart = c3.generate({
            bindto: '#ticket_abierto',
            data: {
                columns: columns,
                type: 'donut'
            },
            donut: {
                title: " ",
                label: {
                    format: function (value, ratio, id) {
                        return value;
                    }
                }
            },
            tooltip: {
                format: {
                    value: function (value, ratio, id) {
                        return value;
                    }
                }
            }
        });
         
    });

    $.post("../../controller/reporte.php?op=graficotoptecnico",function (data) {
        data = JSON.parse(data);

        // new Morris.Bar({
        //     element: 'topgraficotecnico',
        //     data: data,
        //     xkey: 'NombreSoporte',
        //     ykeys: ['TotalAsignados'],
        //     labels: ['Value']
        // });

        var columns = data.map(function(item) {
            return [item.NombreSoporte, item.TotalAsignados];
        });

        var donutChart = c3.generate({
            bindto: '#topgraficotecnico',
            data: {
                columns: columns,
                type: 'donut'
            },
            donut: {
                title: " ",
                label: {
                    format: function (value, ratio, id) {
                        return value;
                    }
                }
            },
            tooltip: {
                format: {
                    value: function (value, ratio, id) {
                        return value;
                    }
                }
            }
        });
         
    });

    $.post("../../controller/reporte.php?op=ticket_sinasignar", function(data) {
        data = JSON.parse(data);

        var columns = data.map(function(item) {
            return [`${item.Ticket} - ${item.Prioridad}`, item.TotalTickets];
        }); 

        var pieChart = c3.generate({
            bindto: '#categoriaprioridad',
            data: {
                columns: columns,
                type: 'pie'
            },
            pie: {
                label: {
                    format: function(value, ratio, id) {
                        return value;
                    }
                }
            },
            tooltip: {
                format: {
                    value: function(value, ratio, id) {
                        return value;
                    }
                }
            }
        });
    });

    
    $.post("../../controller/reporte.php?op=listar_ticket_total", function(data) {
        data = JSON.parse(data);
    
        // Transformar los datos en un formato que C3.js pueda utilizar
        var NombreSoporte = [];
        var abiertos = ['Abierto'];
        var cerrados = ['Cerrado'];
        var totales = ['Total'];
    
        data.aaData.forEach(function(item) {
            NombreSoporte.push(item[0]);
            abiertos.push(item[1]);
            cerrados.push(item[2]);
            totales.push(item[3]);
        });
    
        // Crear el gráfico de barras
        var barChart = c3.generate({
            bindto: '#ticket_tecnico',
            data: {
                columns: [
                    abiertos,
                    cerrados,
                    totales
                ],
                type: 'bar'
            },
            axis: {
                x: {
                    type: 'category',
                    categories: NombreSoporte
                }
            },
            bar: {
                width: {
                    ratio: 0.5
                }
            }
        });
    });
      

    
    $(function() {
        // Inicializar DataTable
        var table = $('#fecha_filtro').DataTable({
            "aProcessing": true,
            "aServerSide": true,
            dom: 'Bfrtip',
            "searching": true, 
            lengthChange: false,
            colReorder: true,
            buttons: [		          
                'excelHtml5',
                'pdfHtml5'
            ],
            "ajax":{
                url: '../../controller/reporte.php?op=rango_fecha_crea',
                type: "post",
                data: function (d) {
                    d.fech_inicio = $('#fech_inicio').val(); // Valor del input Fecha Inicio
                    d.fech_fin = $('#fech_fin').val(); // Valor del input Fecha Fin
                },
                dataType: "json",
                error: function(e){
                    console.log(e.responseText);	
                }
            },
            "bDestroy": true,
            "responsive": true,
            "bInfo": true,
            "iDisplayLength": 10,
            "autoWidth": false, 
            "language": {
                "sProcessing":     "Procesando...",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ningún dato disponible en esta tabla",
                "sInfo":           "Mostrando un total de _TOTAL_ registros",
                "sInfoEmpty":      "Mostrando un total de 0 registros",
                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix":    "",
                "sSearch":         "Buscar:",
                "sUrl":            "",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst":    "Primero",
                    "sLast":     "Último",
                    "sNext":     "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
            }
        });
    
        // Mostrar alerta y actualizar tabla al hacer clic en 'Buscar'
        $('#btnbuscar').on('click', function() {
            let fechaInicio = $('#fech_inicio').val();
            let fechaFin = $('#fech_fin').val();
            let valid = true;
    
            // Validación de los campos de fecha
            if (!fechaInicio) {
                $('#fech_inicio').css('border-color', 'red');
                valid = false;
            } else {
                $('#fech_inicio').css('border-color', '');
            }
    
            if (!fechaFin) {
                $('#fech_fin').css('border-color', 'red');
                valid = false;
            } else {
                $('#fech_fin').css('border-color', '');
            }
    
            if (!valid) {
 
                const Toast = Swal.mixin({
                    toast: true,
                    position: "top-end",
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.onmouseenter = Swal.stopTimer;
                        toast.onmouseleave = Swal.resumeTimer;
                    }
                });
        
                Toast.fire({
                    icon: "error",
                    title: "El campo resaltado no puede estar vacio"
                });
                
 
    
            } else {
                const Toast = Swal.mixin({
                    toast: true,
                    position: "top-end",
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.onmouseenter = Swal.stopTimer;
                        toast.onmouseleave = Swal.resumeTimer;
                    }
                });
        
                Toast.fire({
                    icon: "success",
                    title: "Datos filtrados correctamente"
                });
    
                table.ajax.reload(); // Recargar la tabla con los nuevos parámetros
            }
        });
    
        // Mostrar alerta y ver todo (sin filtrar) al hacer clic en 'Ver Todo'
        $('#btntodo').on('click', function() {
            $('#fech_inicio').val('');
            $('#fech_fin').val('');
            
            const Toast = Swal.mixin({
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.onmouseenter = Swal.stopTimer;
                    toast.onmouseleave = Swal.resumeTimer;
                }
            });
    
            Toast.fire({
                icon: "success",
                title: "Mostrando todos los registros"
            });
    
            table.ajax.reload(); // Recargar la tabla sin filtrar
        });
    });
    

    
});
 
 
init();



 