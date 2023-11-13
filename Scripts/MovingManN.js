RegisterTag("MovingManN", function (StartSizeRAW, MaxSizeRAW, SpeedRAW, SubSizeRAW, ChangeRAW, easeRAW) {
	MaxSizeRAW = MaxSizeRAW.replace(",", "").replace(" ", "");
	SpeedRAW = SpeedRAW.replace(",", "").replace(" ", "");
	SubSizeRAW = SubSizeRAW.replace(",", "").replace(" ", "");
	ChangeRAW = ChangeRAW.replace(",", "").replace(" ", "");
	easeRAW = easeRAW.replace(",", "").replace(" ", "");
    let Func = Combo(); let StartSize = 30; let MaxSize = 80; let Speed = 800; let SubSize = 30;
    if(isNaN(parseFloat(StartSizeRAW))==0){StartSize = StartSizeRAW;}
    if(isNaN(parseFloat(SubSizeRAW))==0){SubSize = SubSizeRAW;}
    if(isNaN(parseFloat(MaxSizeRAW))==0){MaxSize = MaxSizeRAW;}
    if(isNaN(parseFloat(SpeedRAW))==0){Speed = SpeedRAW;}
    if(isNaN(Func)){return SubSize}
    if (Func !== SubFunc){SubFunc = Func;StartTime = new Date().getTime();}
    let elapsedTime = new Date().getTime() - StartTime;
    if (elapsedTime < Speed){
        let INease = (elapsedTime / Speed);
        let ease = INease;
        let easestr = easeRAW.toString().toUpperCase();
        if (easestr == "INSINE"){ease = easeInSine(INease);}
        if (easestr == "OUTSINE"){ease = easeOutSine(INease);}
        if (easestr == "INOUTSINE"){ease = easeInOutSine(INease);}
        if (easestr == "INQUAD"){ease = easeInQuad(INease);}
        if (easestr == "OUTQUAD"){ease = easeOutQuad(INease);}
        if (easestr == "INOUTQUAD"){ease = easeInOutQuad(INease);}
        if (easestr == "INCUBIC"){ease = easeInCubic(INease);}
        if (easestr == "OUTCUBIC"){ease = easeOutCubic(INease);}
        if (easestr == "INOUTCUBIC"){ease = easeInOutCubic(INease);}
        if (easestr == "INQUANT"){ease = easeInQuart(INease);}
        if (easestr == "OUTQUANT"){ease = easeOutQuart(INease);}
        if (easestr == "INOUTQUANT"){ease = easeInOutQuart(INease);}
        if (easestr == "INQUINT"){ease = easeInQuint(INease);}
        if (easestr == "OUTQUINT"){ease = easeOutQuint(INease);}
        if (easestr == "INOUTQUINT"){ease = easeInOutQuint(INease);}
        if (easestr == "INEXPO"){ease = easeInExpo(INease);}
        if (easestr == "OUTEXPO"){ease = easeOutExpo(INease);}
        if (easestr == "INOUTEXPO"){ease = easeInOutExpo(INease);}
        if (easestr == "INCIRC"){ease = easeInCirc(INease);}
        if (easestr == "OUTCIRC"){ease = easeOutCirc(INease);}
        if (easestr == "INOUTCIRC"){ease = easeInOutCirc(INease);}
        if (easestr == "INBACK"){ease = easeInBack(INease);}
        if (easestr == "OUTBACK"){ease = easeOutBack(INease);}
        if (easestr == "INOUTBACK"){ease = easeInOutBack(INease);}
        if (easestr == "INELASTIC"){ease = easeInElastic(INease);}
        if (easestr == "OUTELASTIC"){ease = easeOutElastic(INease);}
        if (easestr == "INOUTELASTIC"){ease = easeInOutElastic(INease);}
        if (easestr == "INBOUNCE"){ease = easeInBounce(INease);}
        if (easestr == "OUTBOUNCE"){ease = easeOutBounce(INease);}
        if (easestr == "INOUTBOUNCE"){ease = easeInOutBounce(INease);}
        let ChangeOut = MaxSize * ease;
        if(ChangeRAW == 1){ChangeOut = MaxSize * (1-ease);}
        let interpolatedValue = ChangeOut;
        if (interpolatedValue > MaxSize) {interpolatedValue = MaxSize;}
        if (interpolatedValue < 0) {interpolatedValue = 0;}
        return (interpolatedValue + parseInt(StartSize)).toFixed(4);
    }
    else{return SubSize;}
}, true);
let SubFunc = Combo(); //이것도 바꿔주세요.
let StartTime = new Date().getTime();
function easeInSine(t) {return 1 - Math.cos((t * Math.PI) / 2);}
function easeOutSine(t) {return Math.sin((t * Math.PI) / 2);}
function easeInOutSine(t) {return -(Math.cos(Math.PI * t) - 1) / 2;}
function easeInQuad(t) {return t * t;}
function easeOutQuad(t) {return 1 - (1 - t) * (1 - t);}
function easeInOutQuad(t) {return t < 0.5 ? 2 * t * t : 1 - Math.pow(-2 * t + 2, 2) / 2;}
function easeInCubic(t) {return t * t * t;}
function easeOutCubic(t) {return 1 - Math.pow(1 - t, 3);}
function easeInOutCubic(t) {return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;}
function easeInQuart(t) {return t * t * t * t;}
function easeOutQuart(t) {return 1 - Math.pow(1 - t, 4);}
function easeInOutQuart(t) {return t < 0.5 ? 8 * t * t * t * t : 1 - Math.pow(-2 * t + 2, 4) / 2;}
function easeInQuint(t) {return t * t * t * t * t;}
function easeOutQuint(t) {return 1 - Math.pow(1 - t, 5);}
function easeInOutQuint(t) {return t < 0.5 ? 16 * t * t * t * t * t : 1 - Math.pow(-2 * t + 2, 5) / 2;}
function easeInExpo(t) {return t === 0 ? 0 : Math.pow(2, 10 * (t - 1));}
function easeOutExpo(t) {return t === 1 ? 1 : 1 - Math.pow(2, -10 * t);}
function easeInOutExpo(t) {if (t === 0) return 0;if (t === 1) return 1;if (t < 0.5){return 0.5 * Math.pow(2, 20 * t - 10);}else{return 1 - 0.5 * Math.pow(2, -20 * t + 10);}}
function easeInCirc(t) {return 1 - Math.sqrt(1 - t * t);}
function easeOutCirc(t) {return Math.sqrt(1 - (t - 1) * (t - 1));}
function easeInOutCirc(t) {if (t < 0.5) {return 0.5 * (1 - Math.sqrt(1 - 4 * t * t));}else{return 0.5 * (Math.sqrt(1 - (2 * t - 2) * (2 * t - 2)) + 1);}}
function easeInBack(t, s = 1.70158) {return t * t * ((s + 1) * t - s);}
function easeOutBack(t, s = 1.70158) {return (t = t - 1) * t * ((s + 1) * t + s) + 1;}
function easeInOutBack(t, s = 1.70158) {if ((t /= 0.5) < 1) return 0.5 * (t * t * (((s *= 1.525) + 1) * t - s));return 0.5 * ((t -= 2) * t * (((s *= 1.525) + 1) * t + s) + 2);}
function easeInElastic(t) {if (t === 0) return 0;if (t === 1) return 1;return -Math.pow(2, 10 * t - 10) * Math.sin((t * 10 - 10.75) * (2 * Math.PI) / 3);}
function easeOutElastic(t) {if (t === 0) return 0;if (t === 1) return 1;return Math.pow(2, -10 * t) * Math.sin((t * 10 - 0.75) * (2 * Math.PI) / 3) + 1;}
function easeInOutElastic(t) {if (t === 0) return 0;if (t === 1) return 1;t *= 2;if (t < 1){return -0.5 * (Math.pow(2, 10 * t - 10) * Math.sin((t * 10 - 10.75) * (2 * Math.PI) / 3));}else{return 0.5 * (Math.pow(2, -10 * (t - 1)) * Math.sin((t * 10 - 10.75) * (2 * Math.PI) / 3)) + 1;}}
function easeInBounce(t) {return 1 - easeOutBounce(1 - t);}
function easeOutBounce(t) {if (t < (1 / 2.75)) {return 7.5625 * t * t;}else if(t < (2 / 2.75)){return 7.5625 * (t -= (1.5 / 2.75)) * t + 0.75;}else if(t < (2.5 / 2.75)){return 7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375;}else{return 7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375;}}
function easeInOutBounce(t) {if (t < 0.5) return easeInBounce(t * 2) * 0.5;return easeOutBounce(t * 2 - 1) * 0.5 + 0.5;}