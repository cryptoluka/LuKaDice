<%-- 
    Document   : Home
    Created on : 17-jul-2018, 21:39:15
    Author     : Arieru
--%>

<%@page import="org.cryptoluka.entity.Player"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        Player pl = null;
        if (request.getSession().getAttribute("player") != null) {
            pl = (Player) request.getSession().getAttribute("player");
        }
    %>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=0.5">
        <title>Dice Game</title>

        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="css/animate.css" rel="stylesheet" />
        <link href="css/font-awesome.min.css" rel="stylesheet" />
        <link href="css/owl.theme.css" rel="stylesheet" />
        <link href="css/owl.carousel.css" rel="stylesheet" />
        <link href="js/confirm/jquery-confirm.min.css" rel="stylesheet" />
        <link href="js/toastr/toastr.min.css" rel="stylesheet" type="text/css" />
        <link href="js/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="js/rangeslider/rangeslider.css" rel="stylesheet" type="text/css" />

        <link type="text/css" rel="stylesheet" href="css/style.css" />
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600" rel="stylesheet" />


        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/datatables/datatables.min.js"></script>
        <script type="text/javascript" src="js/rangeslider/rangeslider.min.js"></script>
        <script type="text/javascript" src="js/cookies/cookie.js"></script>
        <script type="text/javascript" src="js/moment.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/toastr/toastr.js"></script>
        <script type="text/javascript" src="js/daemons/daemons.js"></script>
        <script type="text/javascript" src="js/confirm/jquery-confirm.min.js"></script>
        <script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
        <script type="text/javascript" src="js/qrcode.js"></script>

        <style>

        </style>

    </head>
    <body>

        <!-- =========================
                NAVIGATION LINKS     
        ============================== -->

        <div class="navbar custom-navbar fixed in-view" role="navigation">
            <div class="container"><!-- navbar header -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">
                        <img alt="Luka isotipo" class="isotipo" src="images/isotipo-luka.svg" />
                        <img alt="Luka logotipo" class="logotipo" src="images/logotipo-luka.svg" />
                    </a>

                    <button class="navbar-toggle" data-target=".navbar-collapse" data-toggle="collapse"></button>
                </div>

                <div style="text-align: center; position: absolute; margin-left: 30%; display: block; transform: none; top: 0; margin-top: 15px">
                    <h4>JACKPOT: <span id="jackpotNumber">0.00000000</span> LUK</h4>
                </div>


                <div class="collapse navbar-collapse" id="navbar-collapsible">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active"><a class="scroll" href="#">DICE</a></li>
                        <li><a class="scroll" href="#">MORE COMING SOON...</a></li>
                    </ul>
                </div>
            </div>
        </div>


        <!-- =========================
                HEADER GAME     
        ============================== -->
        <div style="margin-top: 80px; text-align: center">


            <img src="images/logo_LukaDice.svg" style="max-width: 20%; min-width: 300px; margin-bottom: 20px; margin-top: 10px;" />

            <div class="row" style="width: 96%; margin: auto">

                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12" style="text-align: left; border: solid 1px white; margin-right: 2%;">

                    <% if (pl != null) {%>

                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 1vh">

                        <div class="pull-right">

                            <button onclick="closeSession()" class="btn-warning"><i class="fa fa-power-off"></i></button>
                            <button onclick="editProfile()" class="btn-info"><i class="fa fa-pencil"></i></button>
                            <button onclick="deposit()" class="btn-success"><i class="fa fa-download"></i></button>
                            <button onclick="retirar()" class="btn-danger"><i class="fa fa-share"></i></button>
                        </div>
                        <div>

                            <p>NickName: <%= pl.getUsername()%> </p> 
                            <p>Balance: <span id="myBalance"><%= pl.getBalance()%></span> LUK</p>
                            <p style="color: #0f0">Win Times: <span id="winTime">0</span></p>
                            <p style="color: red">Lose Times: <span id="loseTime">0</span></p>
                        </div>
                    </div>

                    <% } else { %>

                    <div class="row"  style="color: white; text-align: center;">
                        <button onclick="switchLogin(1)" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 btn-default" style="background-color: #a3b0c9">LOGIN</button>
                        <button onclick="switchLogin(2)" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 btn-default" style="background-color: #484d5f">REGISTER</button>
                    </div>

                    <div id="panelLogin">

                    </div>

                    <% }%>

                </div>

                <div class="col-lg-5 col-md-5" style="text-align: left; border: solid 1px white;">

                    <div class="row"  style="color: white; text-align: center">
                        <button class="col-lg-6 col-md-6 col-sm-6 col-xs-6 btn-default" style="background-color: #a3b0c9">MANUAL BETTING</button>
                        <button class="col-lg-6 col-md-6 col-sm-6 col-xs-6 btn-default" style="background-color: #484d5f">AUTOMATED BETTING </button>
                    </div>

                    <div style="margin-top: 2vh; margin-left: 5%; margin-right: 5%" class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 0">
                            <input id="myBetValue" class="input-lg" style="width: 100%" value="0.00000010" step="0.00000001" min="0.00001000" max="100" type="number" />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4" style="padding: 0">
                            <button onclick="divideButton()" class="form-control btnBets">/2</button>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4" style="padding: 0">
                            <button onclick="doubleButton()" class="form-control btnBets">X2</button>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4" style="padding: 0">
                            <button onclick="maxButton()" class="form-control btnBets">MAX</button>
                        </div>
                    </div>


                    <div class="row"style="text-align: center">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <h4 >Payout</h4>
                            <h3 id="payout"></h3>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <h4 >Win Chance</h4>
                            <h3 id="chance"></h3>
                        </div>
                    </div>


                    <div style="margin-top: 2vh; margin-bottom: 1vh; text-align: center">
                        <button id="playButton" class="btn btn-lg btn-success btn-block" style="width: 50%; margin: auto" onclick="play()">ROLL!</button>
                    </div>

                </div>
                <div class="col-lg-3 col-md-3 hidden-sm hidden-xs" style="text-align: left; margin-left: 2%; border: solid 1px white">
                    <p>AQUI VA UN GRAFICO</p>
                </div>
            </div>

            <h1 id="number"></h1>
            <h3 id="response"></h3>


            <div style="height: 7vh"></div>

            <input type="range" id="betRange" min="0" max="9999" />

            <div style="height: 7vh"></div>


            <div class="row pull-right" style="text-align: right; margin-right: 4%; display: inline-block"  >
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" >
                    <button onclick="" class="">My last bets</button>
                    <button onclick="" class="">Recent bets</button>
                    <button onclick="" class="">High rollers</button>
                    <button onclick="" class="">History</button>
                </div>
            </div>
            <table id="diceTable" class="table  table-condensed cell-border" >
                <thead>
                    <tr >
                        <th style="text-align: center">GAME ID</th>
                        <th style="text-align: center">PLAYER</th>
                        <th style="text-align: center">TIME (UTC)</th>
                        <th style="text-align: center">BET</th>
                        <th style="text-align: center">TARGET</th>
                        <th style="text-align: center">NUMBER</th>
                        <th style="text-align: center">RESULT</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>

        <script>

            var count = 0;
            var wins = 0;
            var loses = 0;
            var table = null;
            var target = 0;
            var payout = 0;
            var myBalance = 0;
            var token = "";
            var paymentID = "";
            var user_nickname = "";
            var user_email = "";
            <%
                if (pl != null) {
            %>
            myBalance = "<%= pl.getBalance()%>";
            paymentID = "<%= pl.getPaymentid()%>";
            user_nickname = "<%= pl.getNickname()%>";
            user_email = "<%= pl.getEmail()%>";
            <%
                }
            %>

            $(function () {

                // INIT TABLE
                table = $('#diceTable').DataTable({
                    "dom": '<"top">rt<"bottom"><"clear">',
                    "ordering": false,
                    "pageLength": 7
                });
                // SETUP DEFAULT VALUES
                $('#winTime').text(wins);
                $('#loseTime').text(loses);
                $('#betRange').val(5000).change();
                // SETUP ALERTS
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-bottom-left",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "100",
                    "hideDuration": "800",
                    "timeOut": "800",
                    "extendedTimeOut": "800",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                switchLogin(1); // login

                runDaemons(); // run daemons

            });
            function play() {

                var myBetValue = $('#myBetValue').val();
                if (myBetValue === '' || myBetValue === null || myBetValue === undefined || myBetValue.length < 1) {
                    toastr.info('Acción no es posible');
                    return;
                }

                if (myBalance < 0.00000010) {
                    console.log("Insufficient Funds");
                    toastr.error('Fondos insuficientes');
                    return;
                }

                if (myBetValue > myBalance) {
                    console.log("Insufficient Funds");
                    toastr.error('Fondos insuficientes');
                    return;
                }

                var betRange = $('#betRange').val();
                $('#playButton').prop('onclick', null).off('click');
                $.ajax({
                    url: "playDice",
                    data: {
                        target: target,
                        payout: payout,
                        balance: myBalance,
                        bet: $('#betRange').val(),
                        apuesta: myBetValue
                    },
                    type: "POST",
                    dataType: "json"
                }).done(function (data, textStatus, jqXHR) {

                    // VARIABLES
                    count = count + 1;
                    var number = data.number;
                    // SETUP TEXTS
                    $('#number').text(number);
                    if (number < betRange) {

                        myBalance = Number(data.balance);
                        wins++;
                        toastr.success("+" + data.profit);
                        $('#response').text("Has Ganado!");
                        $('#myBalance').text(myBalance);
                        $('#winTime').text(wins);
                        addRowZero(data.roll_uuid, data.nickname, myBetValue + " LUK", number, "<span style='color: #0f0'>YOU WON</span>");
                    } else {

                        myBalance = Number(data.balance);
                        loses++;
                        toastr.error("-" + data.profit);
                        $('#myBalance').text(myBalance);
                        $('#loseTime').text(loses);
                        $('#response').text("Has Perdido");
                        addRowZero(data.roll_uuid, data.nickname, myBetValue + " LUK", number, "<span style='color: red'>YOU LOSE</span>");
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("Error con el servidor");
                    toastr.error(errorThrown);
                }).always(function () {
                    $('#playButton').on('click', function () {
                        play();
                    });
                });
            }


            function addRowZero(gameID, player, bet, number, result) {

                var newRow = [gameID, player, moment().utc().format('DD/MM/YY HH:MM:ss'), bet, 'x' + payout, number, result]; // new row in the datatable
                var index = 0; // index for the new row to be added
                var currentRows = table.data().toArray(); // current table data
                currentRows.splice(index, 0, newRow);
                table.clear();
                table.rows.add(currentRows);
                table.draw();
            }
        </script>


        <script>
            var valueBubble = '<output class="rangeslider__value-bubble" />';
            function updateValueBubble(pos, value, context) {
                pos = pos || context.position;
                value = value || context.value;
                var $valueBubble = $('.rangeslider__value-bubble', context.$range);
                var tempPosition = pos + context.grabPos;
                var position = (tempPosition <= context.handleDimension) ? context.handleDimension : (tempPosition >= context.maxHandlePos) ? context.maxHandlePos : tempPosition;
                if ($valueBubble.length) {
                    $valueBubble[0].style.left = Math.ceil(position) + 'px';
                    $valueBubble[0].innerHTML = value;
                }
            }

            $('input[type="range"]').rangeslider({
                polyfill: false,
                onInit: function () {
                    this.$range.append($(valueBubble));
                    updateValueBubble(null, null, this);
                },
                onSlide: function (pos, value) {

                    if (value < 100) {
                        $('#betRange').val(100).change();
                        return;
                    }

                    if (value > 9799) {
                        $('#betRange').val(9799).change();
                        return;
                    }

                    updateValueBubble(pos, value, this);
                    var betPercent = ((value) / 9999) * 100;
                    payout = (99 / betPercent).toFixed(2);
                    target = betPercent.toFixed(2);
                    $('#payout').text(payout + "x");
                    $('#chance').text(betPercent.toFixed(2) + "%");
                }
            });
            function doubleButton() {

                var myBetValue = $('#myBetValue').val();
                var myNewBetValue = myBetValue * 2;
                if (myNewBetValue >= 1000) {
                    myNewBetValue = 1000;
                }

                if (myNewBetValue > Number(myBalance)) {
                    myNewBetValue = Number(myBalance);
                }

                $('#myBetValue').val(myNewBetValue.toFixed(8));
            }

            function divideButton() {
                var myBetValue = $('#myBetValue').val();
                var myNewBetValue = myBetValue / 2;
                if (myNewBetValue <= 0.00000010) {
                    myNewBetValue = 0.00000010;
                }

                $('#myBetValue').val(myNewBetValue.toFixed(8));
            }

            function maxButton() {

                var apostable = Number(myBalance).toFixed(8) - 0.00000001;
                if (apostable > 100) {
                    $('#myBetValue').val(100.00000000);
                } else {
                    $('#myBetValue').val(apostable);
                }


            }


            function switchLogin(id) {

                if (id === 1) {

                    var texto = "";
                    texto += "<div style='margin-top: 2vh; margin-bottom: 1vh; text-align: center'>";
                    texto += "<input placeholder='email' id='email' class='input-sm' style='width: 80%; margin-bottom: 1vh' type='text' />";
                    texto += "<input placeholder='password' id='password' class='input-sm' style='width: 80%' type='password' />";
                    texto += "</div>";
                    texto += "<div style='margin-top: 2vh; margin-bottom: 1vh;'>";
                    texto += "<button id='loginButton' class='btn-sm btn-success btn-block' style='width: 80%; margin: auto' onclick='login()'>Login</button>";
                    texto += "</div>";
                    $('#panelLogin').html(texto);
                } else if (id === 2) {

                    var texto = "";
                    texto += "<div style='margin-top: 2vh; margin-bottom: 1vh; text-align: center'>";
                    texto += "<input placeholder='email' id='email' class='input-sm' style='width: 80%; margin-bottom: 1vh' type='text' />";
                    texto += "<input placeholder='password' id='password' class='input-sm' style='width: 80%; margin-bottom: 1vh' type='password' />";
                    texto += "<input placeholder='confirm password' id='password2' class='input-sm' style='width: 80%' type='password' />";
                    texto += "</div>";
                    texto += "<div style='margin-top: 2vh; margin-bottom: 1vh;'>";
                    texto += "<button id='registerButton' class='btn-sm btn-info btn-block' style='width: 80%; margin: auto' onclick='register()'>Register</button>";
                    texto += "</div>";
                    $('#panelLogin').html(texto);
                }

            }

            function register() {

                var email = $('#email').val();
                var pass1 = $('#password').val();
                var pass2 = $('#password2').val();

                if (email === null || email === undefined || email.trim().length < 1 || email.trim() === "") {
                    toastr.error("Debe ingresar correo");
                    return;
                }

                if (pass1 === null || pass1 === undefined || pass1.trim().length < 1 || pass1.trim() === "") {
                    toastr.error("Debe ingresar contraseña");
                    return;
                }

                if (pass2 === null || pass2 === undefined || pass2.trim().length < 1 || pass2.trim() === "") {
                    toastr.error("Debe confirmar contraseña");
                    return;
                }

                if (pass1 !== pass2) {
                    toastr.error("Contraseñas no coinciden");
                    return;
                }

                if (email.length > 190) {
                    toastr.error("Correo ingresado excede el largo permitido");
                    return;
                }

                if (!email.includes("@") || !email.substring(email.length - 4, email.length).includes(".")) {
                    toastr.error("Debe ingresar un correo válido");
                    return;
                }

                $.ajax({
                    url: "register",
                    data: {
                        email: email,
                        pass1: pass1,
                        pass2: pass2
                    },
                    type: "POST",
                    dataType: "json"
                }).done(function (data, textStatus, jqXHR) {

                    if (data.status === "OK") {
                        window.location.reload();
                    } else {
                        toastr.error(data.status);
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("Error con el servidor");
                    toastr.error("Error con el servidor");
                }).always(function () {
                });
            }

            function login() {

                var email = $('#email').val();
                var pass = $('#password').val();
                
                if (email === null || email === undefined || email.trim().length < 1 || email.trim() === "") {
                    toastr.error("Debe ingresar correo");
                    return;
                }

                if (pass === null || pass === undefined || pass.trim().length < 1 || pass.trim() === "") {
                    toastr.error("Debe ingresar contraseña");
                    return;
                }
                
                if (email.length > 190) {
                    toastr.error("Correo ingresado excede el largo permitido");
                    return;
                }

                if (!email.includes("@") || !email.substring(email.length - 4, email.length).includes(".")) {
                    toastr.error("Debe ingresar un correo válido");
                    return;
                }



                $.ajax({
                    url: "login",
                    data: {
                        email: email,
                        pass: pass
                    },
                    type: "POST",
                    dataType: "json"
                }).done(function (data, textStatus, jqXHR) {

                    if (data.status === "OK") {
                        window.location.reload();
                    } else {
                        toastr.error(data.status);
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("Error con el servidor");
                    toastr.error("Error con el servidor");
                }).always(function () {
                });
            }

            function closeSession() {

                $.ajax({
                    url: "closeSession",
                    type: "POST",
                    dataType: "json"
                }).done(function (data, textStatus, jqXHR) {

                    if (data.status === "OK") {
                        window.location.reload();
                    } else {
                        toastr.error("No se pudo cerrar la sesión");
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("Error con el servidor");
                    toastr.error("Error con el servidor");
                }).always(function () {
                });
            }

            function editProfile() {

                var contenido = "";

                contenido += "<div style='text-align: left'>";
                contenido += "<strong style='color: black'>Nickname</strong>";
                contenido += "<input class='form-control' value='" + user_nickname + "' />";
                contenido += "<strong style='color: black'>Email</strong>";
                contenido += "<input class='form-control' value='" + user_email + "' />";
                contenido += "</div>";

                $.confirm({
                    icon: "",
                    title: "Editar Perfil",
                    content: contenido,
                    theme: "modern",
                    buttons: {
                        confirm: {
                            text: "Actualizar",
                            btnClass: "btn-success",
                            action: function () {

                            }
                        },
                        cancel: {
                            text: "Cancelar",
                            btnClass: "btn-danger",
                            action: function () {

                            }
                        }
                    }
                });
            }

            function deposit() {

                var contenido = "";
                contenido += "<div style='max-height: 220px;'>";
                contenido += "<div id='myQR' style='width: 230px; height: 220px'></div>";
                contenido += "</div>";
                contenido += "<div style='text-align: left'>";
                contenido += "<strong style='color: black'>LUK Address Wallet</strong>";
                contenido += "<input class='form-control' disabled value='LPVp3vicPY4DSdw4EvEtCY91wH4RA4vmmC1xiSpdmMxHJZx4ieAg8Ty7Y6mdLaMywERUNpyRqHMDwRknRcbqNNeSQVGrcJn' />";
                contenido += "<strong style='color: red'>Payment ID</strong>";
                contenido += "<input class='form-control' value='" + paymentID + "' disabled />";
                contenido += "</div>";

                $.confirm({
                    icon: "",
                    title: "Depositar LUK",
                    content: contenido,
                    theme: "modern",
                    onContentReady: function () {
                        $('#myQR').qrcode({
                            width: 1024,
                            height: 1024,
                            text: "luka:LPVp3vicPY4DSdw4EvEtCY91wH4RA4vmmC1xiSpdmMxHJZx4ieAg8Ty7Y6mdLaMywERUNpyRqHMDwRknRcbqNNeSQVGrcJn?payment_id=" + paymentID
                        });

                        $('#myQR').css('position', 'relative');
                        $('#myQR').css('margin', 'auto');
                        $('#myQR').css('margin-bottom', '10px');
                    },
                    buttons: {
                        confirm: {
                            text: "Confirmar",
                            btnClass: "btn-success",
                            action: function () {

                            }
                        }
                    }
                });
            }

            function retirar() {

                var contenido = "";

                contenido += "<div style='text-align: center;>";
                contenido += "<h3 style='color: black'>" + myBalance + "</h3>";
                contenido += "</div>";

                contenido += "<div style='text-align: left'>";
                contenido += "<strong style='color: black'>LUK Address Wallet</strong>";
                contenido += "<input class='form-control' />";

                contenido += "<div style='text-align: left'>";
                contenido += "<strong style='color: black'>Amount</strong>";
                contenido += "<input type='number' min='1' max='" + myBalance + "' step='0.00000010' value='0.0..Z' class='form-control' />";

                contenido += "<strong style='color: red'>Payment ID</strong>";
                contenido += "<input class='form-control' />";
                contenido += "</div>";

                $.confirm({
                    icon: "",
                    title: "Retirar LUK",
                    content: contenido,
                    theme: "modern",
                    buttons: {
                        confirm: {
                            text: "Confirmar",
                            btnClass: "btn-success",
                            action: function () {

                            }
                        },
                        cancel: {
                            text: "Cancelar",
                            btnClass: "btn-danger",
                            action: function () {

                            }
                        }
                    }
                });
            }

        </script>
    </body>
</html>
