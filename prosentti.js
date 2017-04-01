var number = 50;
var colour =71-(number-5)*71/90;
var numberLabel = document.getElementById("number");
var colourBack = document.getElementById("leftTop");
var seconds=0;

setInterval(setColour,1000);

function setColour(){
	if (seconds%10===0 ){
		updatePercentage();
		colour =71-(number-5)*71/90;
		var hslColour = "hsl("+colour+",100%,30%)";
		numberLabel.innerHTML=number+"%";
		colourBack.style.backgroundColor=hslColour;
	}
	seconds=seconds+1;
}