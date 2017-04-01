    var minutesLabel = document.getElementById("minutes");
    var secondsLabel = document.getElementById("seconds");
    var hoursLabel    = document.getElementById("hours");
    var totalSeconds = 0;
    setInterval(setTime, 1000);

    function setTime()
    {
        ++totalSeconds;
        secondsLabel.innerHTML = pad(totalSeconds%60);
        minutesLabel.innerHTML = pad(parseInt((totalSeconds/60)%60));
        hoursLabel.innerHTML   = pad(parseInt((totalSeconds/3600)));
    }

    function pad(val)
    {
        var valString = val + "";
        if(valString.length < 2)
        {
            return "0" + valString;
        }
        else
        {
            return valString;
        }
    }

var number = updatePercentage();

function updatePercentage() {
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
           if (xmlhttp.status == 200) {
               number = xmlhttp.responseText;
           }
           else if (xmlhttp.status == 400) {
              	number = "50";
           }
           else {
               number = "50";
           }
        }
    };

    xmlhttp.open("GET", "/Hackday/Ennuste/Ennuste.php", true);
    xmlhttp.send();
}
