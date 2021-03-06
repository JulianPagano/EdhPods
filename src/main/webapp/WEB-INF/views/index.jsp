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
  
    <style type="text/css">
    
      /* Animacion del loader */
      .loader {
        border: 16px solid #f3f3f3; /* Light grey */
        border-top: 16px solid #3498db; /* Blue */
        border-radius: 50%;
        width: 100px;
        height: 100px;
        animation: spin 2s linear infinite;
        /*position: absolute;*/
        left: 0;
        top: 0;
        right: 0;
        bottom: 0;
        margin: auto;
      }
      
      .tiny-loader {
        border: 4px solid #f3f3f3; /* Light grey */
        border-top: 4px solid #3498db; /* Blue */
        border-radius: 50%;
        width: 20px;
        height: 20px;
        animation: spin 2s linear infinite;
        /*position: absolute;*/
        left: 0;
        top: 0;
        right: 0;
        bottom: 0;
        margin: auto;
      }
      
      @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
      }
      /* FIN Animacion del loader */
    
    </style>

  </head>
  
  <body>

    <!-- Page Content -->
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <h2 class="mt-2 text-center" id="quest-title">Jugadores</button></h2>
          <div id="players-input">
              <div class="form-group">
                <textarea class="form-control rounded-0" style="resize: none;" id="players-textarea" rows="3" placeholder="Pagano, Bruno P, Tanke, Denis, ..."></textarea>
                <span class="badge badge-secondary float-right" id="num-players" style="margin-top: -23px; margin-right: 5px;">0 Jugadores</span>
              </div>
          </div>
          <h1 id="create-pods-button"><button type="button" class="btn btn-primary btn-lg btn-block">Generar!</button></h1>
        </div>
      </div>
      <div class="loader" id="loader" style="display:none"></div>
      <div id="created-pods-div" class="row">
      </div>
    </div>

    <!-- jQuery first, then Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" integrity="sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  
    <script type="text/javascript">

      var arrPlayers;

      /**
      * Randomize array element order in-place.
      * Using Durstenfeld shuffle algorithm.
      */
      function shuffleArray(array) {
          for (var i = array.length - 1; i > 0; i--) {
              var j = Math.floor(Math.random() * (i + 1));
              var temp = array[i];
              array[i] = array[j];
              array[j] = temp;
          }
      }

      $(document)
        .on({
          ajaxStart: function() {
              $('#loader').fadeIn('fast');
          }, 
          ajaxError: function() {
              $('#loader').hide();
          }
        });

      $('#create-pods-button')
        .on('click', function(event) {
          event.preventDefault(); // To prevent following the link (optional)
          startQuest();
        });

      $('#players-textarea')
        .keyup(function() {
          var countPlayers;
          var countTables;
          
          var strPlayers = $('#players-textarea').val().trim();
          arrPlayers = strPlayers.split(',').filter(function(v){return v!==''});

          $('#num-players').html(arrPlayers.length + ' jugadores');
        });

      function startQuest() {
        
        $('#created-pods-div').empty();
        
        var request = $.ajax({
          type : "POST",
          url : "${home}createPods",
          data: { arrPlayers },
          success : function(response) {
            console.log("SUCCESS: ", response);

            var tableNames = ['La mesa de la megamuerte', 
                              'La mesa del castigo infinito', 
                              'La mesa del inframundo', 
                              'La mesa del mism\u00EDsimo infierno', 
                              'La mesa de la maldad absoluta', 
                              'La mesa de la tortura eterna'];
            shuffleArray(tableNames);

            var alertColors = ['alert alert-primary', 
                               'alert alert-secondary', 
                               'alert alert-success', 
                               'alert alert-danger', 
                               'alert alert-warning', 
                               'alert alert-info'];
            shuffleArray(alertColors);

            $('#loader').hide();

            var i, j;
            for (i = 0; i < response.length; i++) {
              var colDiv 		= $('<div></div>').addClass('col-lg-4');
              var alertDiv 	= $('<div></div>').addClass('alert').addClass(alertColors[i]);
              var alertTitle 	= $('<h5></h5>').addClass('alert-heading').text(tableNames[i]);
              alertDiv.append(alertTitle);
              var alertUl 	= $('<ul></ul>').addClass('list mb-0');
              
              for (j = 0; j < response[i].length; j++) {
                if (response[i][j] != null) {
                  var alertLi = $('<li></li>').addClass('list-item').text(response[i][j]);
                  alertUl.append(alertLi);
                }
              }	
              
              alertDiv.append(alertUl);
              colDiv.append(alertDiv);
              $('#created-pods-div').append(colDiv);
            }

            $('#created-pods-div').fadeIn('slow');
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