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

    await delay(3000);
    runDaemons();
}



function getJackpot() {

    var req = $.get('getInfo?method=jackpot');

    req.done(function (response) {
        if(response.status === "OK") {
            $('#jackpotNumber').text(response.jackpot);
        } else {
            console.log('Message: ' + response.message);
        }
    });

    req.fail(function (response) {
        console.log('No Jackpot Info');
    });

}





