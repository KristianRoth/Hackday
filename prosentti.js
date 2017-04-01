var number = 50;
var colour =71-(number-5)*71/90;
var numberLabel = document.getElementById("number");
var seconds=0;

setInterval(setColour,1000);

function setColour(){
	if (seconds%10===0 ){
		numberLabel.innerHTML=number+"%";
		
	}
	seconds=seconds+1;
}