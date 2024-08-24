var tabla;

function init() {
  $("#ticket_form").on("submit", function (e) {
    guardaryeditar(e);
  });

  $("#usuario_form").on("submit", function(e) {
    guardaryeditarusuario(e);
  });
}

/* TODO: Guardar datos de los input */
function guardaryeditarusuario(e){
  e.preventDefault();
  var formData = new FormData($("#usuario_form")[0]);
  $.ajax({
    url: "../../controller/usuario.php?op=guardaryeditar",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function(datos){
      console.log(datos);
      if(datos == "1"){
        $('#usuario_form')[0].reset();
        /* TODO:Ocultar Modal */
        $("#modalmantenimiento").modal('hide');
        $('#usuario_data').DataTable().ajax.reload();

        /* TODO:Mensaje de Confirmacion */
        swal({
          title: "HelpDesk!",
          text: "Registrado Correctamente.",
          type: "success",
          confirmButtonClass: "btn-success"
        });
      }else if(datos == "2"){
        $('#usuario_form')[0].reset();
        /* TODO:Ocultar Modal */
        $("#modalmantenimiento").modal('hide');
        $('#usuario_data').DataTable().ajax.reload();

        /* TODO:Mensaje de Confirmacion */
        swal({
          title: "HelpDesk!",
          text: "Actualizado Correctamente.",
          type: "success",
          confirmButtonClass: "btn-success"
        });
      }else if(datos=="0"){
        $("#usu_correo").addClass("form-control-error");
        $("<small class='text-muted text-danger'>El Registro ya existe</small>").insertAfter("#usu_correo");
      }
    }
  });
}

$(document).ready(function () {
  /* TODO: Inicializar SummerNote */
  $("#tick_descrip").summernote({
    height: 150,
    lang: "es-ES",
    popover: {
      image: [],
      link: [],
      air: [],
    },
    callbacks: {
      onImageUpload: function (image) {
        console.log("Image detect...");
        myimagetreat(image[0]);
      },
      onPaste: function (e) {
        console.log("Text detect...");
      },
    },
    toolbar: [
      ["style", ["bold", "italic", "underline", "clear"]],
      ["font", ["strikethrough", "superscript", "subscript"]],
      ["fontsize", ["fontsize"]],
      ["color", ["color"]],
      ["para", ["ul", "ol", "paragraph"]],
      ["height", ["height"]],
    ],
  });

  /* TODO: Llenar Combo categoria */
  $.post("../../controller/categoria.php?op=combo", function (data, status) {
    $("#cat_id").html(data);
  });

  $("#cat_id").change(function () {
    cat_id = $(this).val();
    /* TODO: llenar Combo subcategoria segun cat_id */
    $.post(
      "../../controller/subcategoria.php?op=combo",
      { cat_id: cat_id },
      function (data, status) {
        $("#cats_id").html(data);
      }
    );
  });

  /* TODO: Llenar combo Prioridad  */
  $.post("../../controller/prioridad.php?op=combo", function (data, status) {
    $("#prio_id").html(data);
  });
});

function guardaryeditar(e) {
  e.preventDefault();

  $("#btnguardar").prop("disabled", true);
  $("#btnguardar").html('<i class="fa fa-spinner fa-spin"></i> Espere..');

  var formData = new FormData($("#ticket_form")[0]);

  if ($("#tick_descrip").summernote("isEmpty") || $("#tick_titulo").val() == "" || $("#cats_id").val() == 0 || $("#cat_id").val() == 0 || $("#prio_id").val() == 0) {
    swal("Advertencia!", "Campos Vacios", "warning");
    $("#btnguardar").prop("disabled", false);
    $("#btnguardar").html("Guardar");
  } else {
    var totalfiles = $("#fileElem").val().length;
    for (var i = 0; i < totalfiles; i++) {
      formData.append("files[]", $("#fileElem")[0].files[i]);
    }

    var rol_id = $("#rol_id").val(); // Suponiendo que tienes el rol_id disponible en un elemento oculto
    console.log('rol_id', rol_id); // '3' o '4

    if (rol_id == 3 || rol_id == 4) {
      formData.append("usu_id", $("#usu_id_incidencia").val());
    } else {
      formData.append("usu_id", $("#usu_id").val());
    }

    $.ajax({
      url: "../../controller/ticket.php?op=insert",
      type: "POST",
      data: formData,
      contentType: false,
      processData: false,
      success: function (data) {
        console.log(data);
        data = JSON.parse(data);
        console.log(data[0].tick_id);

        $.post("../../controller/email.php?op=ticket_abierto", { tick_id: data[0].tick_id }, function (data) {});

        $("#tick_titulo").val("");
        $("#tick_descrip").summernote("reset");
        swal("Correcto!", "Ticket Registrado Correctamente: Nro-" + data[0].tick_id, "success");

        $("#btnguardar").prop("disabled", false);
        $("#btnguardar").html("Guardar");
      },
    });
  }
}

/* TODO: Limpiar Inputs */
$(document).on("click","#btnnuevo", function(){
  $('#usu_id').val('');
  $('#mdltitulo').html('Nuevo Registro');
  $('#usuario_form')[0].reset();

  $("#usu_correo").removeClass("form-control-error");
  $("#usu_correo + small").remove();

  /* TODO:Mostrar Modal */
  $('#modalmantenimiento').modal('show');
});

init();
