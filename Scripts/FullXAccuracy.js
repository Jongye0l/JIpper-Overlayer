RegisterTag("FullXAccuracyJ", function () {
    if(XAccuracy() === 100){return "<color=#FFDA00>" + XAccuracy(2) + "%</color>"}
    else{return XAccuracy(2)}
}, true);