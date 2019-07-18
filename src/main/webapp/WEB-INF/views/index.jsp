<!doctype html>
<html lang="es">
  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Small web-app to generate randomized EDH pods.">
    <meta name="author" content="Julian Pagano">
  
    <title>EDH Pods</title>
  
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  
  </head>
  
  <body>

    <!-- Page Content -->
    <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h1 class="mt-5" id="create-pods-button"><button type="button" class="btn btn-primary btn-lg btn-block">Generar!</button></h1>
            <div class="loader" id="loader" style="display:none"></div>
            <h1 class="mt-5" id="quest-title">EDH Pods!</button></h1>
            <div id="players-input">
                <div class="form-group">
                  <textarea class="form-control rounded-0" style="resize: none;" id="players-textarea" rows="3" placeholder="Pagano, Bruno P, Tanke, Denis, ..."></textarea>
                </div>
            </div>
            <div id="created-pods" style="display:none">

            </div>
          </div>
        </div>
      </div>

    <!-- jQuery first, then Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" integrity="sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  
    <script type="text/javascript">

      $(document)
        /* Esconder el loader animado al completar la consulta Ajax */
        .on({
            ajaxStop: function() {
              $('#loader').hide();
            }
        });

      $('#create-pods-button')
        .on('click', function(event) {
          event.preventDefault(); // To prevent following the link (optional)
          startQuest();
        });

      function startQuest() {
        
        $('#loader').fadeOut('fast');
        
        var request = $.ajax({
          type : "POST",
          url : "${home}createPods",
          success : function(response) {
            console.log("SUCCESS: ", response);
            $('#created-pods').fadeIn('slow');
          },
          error : function(e) {
            console.log("ERROR: ", e);
          },
          done : function(e) {
            console.log("DONE");
          }
        });
      }
    </script>

  </body>
</html>