function delay(t) {
    return new Promise(function (resolve) {
        setTimeout(resolve, t)
    });
}

// PRICES VARIABLES
var jackpot = 0.00000000;


async function runDaemons() {

    // DAEMONS
    getJackpot();
    getLast7Plays();

    await delay(3000);
    runDaemons();
}



function getJackpot() {

    var req = $.get('getInfo?method=jackpot');

    req.done(function (response) {
        if (response.status === "OK") {
            $('#jackpotNumber').text(response.jackpot);
        } else {
            console.log('Message: ' + response.message);
        }
    });

    req.fail(function (response) {
        console.log('No Jackpot Info');
    });

}

function getLast7Plays() {

    var req = $.get('getInfo?method=last7plays');

    req.done(function (response) {
        if (response.status === "OK") {

            tableRecentBets.clear();

            $.each(response.message, function (index, objeto) {

                var res = "<span style='color: red'>LOSE<span>";

                if (objeto.result) {
                    res = "<span style='color: #0f0'>WON<span>";
                }

                tableRecentBets.row.add([
                    objeto.gameid,
                    objeto.player,
                    objeto.time,
                    objeto.bet,
                    objeto.target,
                    objeto.number,
                    res
                ]).draw();
            });

        } else {
            console.log('Message: ' + response.message);
        }
    });

    req.fail(function (response) {
        console.log('No 7 plays Info');
    });

}





