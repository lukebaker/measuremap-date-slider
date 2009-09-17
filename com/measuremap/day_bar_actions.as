/*bar_code.as
*Location is attached to every day_mc (_root.slider_mc.day_mc)

*/
//set the color of the bar
bar_mc.colorTo("0x"+_parent._parent.bar_color, 0);
//set the dayreadout...send raw value to function to convert to month
dayreadout = convertMonth(dayreadout_raw.slice(4, 6), dayreadout_raw.slice(6, 8));
year = dayreadout_raw.slice(2, 4);
month = Number(dayreadout_raw.slice(4, 6))-1;
date = dayreadout_raw.slice(6, 8);
//get the day (Mon. Tues....)
var today_date:Date = new Date(year, month, date);
// output will be based on local timezone
var dayOfWeek_array:Array = new Array("Sun.", "Mon.", "Tues.", "Wed.", "Thur.", "Fri.", "Sat.");
var day:String = dayOfWeek_array[today_date.getDay()-Number(1)];
if (day == undefined) {
	day = "Sat.";
}
//
//
this.onEnterFrame = function() {
	//find the min date in the range
	//see if the day is in th range of the handles 
	//if this is true it's outside
	if (this._x<=(_parent.sliderone_mc._x+_parent.sliderone_mc._width-1) || this._x>(_parent.slidertwo_mc._x)) {
		//this.alphaTo(40);
		this._alpha = 40;
		this.in_range = "no";
	} else {
		this._alpha = 100;
		this.in_range = "yes";
		findingmin = _parent.sliderone_mc._x-this._x;
		if (findingmin<=-1) {
			// output will equal getDay() plus or minus one
			_parent.readoutmin_mc.readoutmin = day+" "+dayreadout;
			_parent.readoutmin_raw = dayreadout_raw;
			_parent.minpos = this._x;
		}
		findingmax = _parent.slidertwo_mc._x-this._x;
		distance = _parent.slidertwo_mc._width;
		if (findingmax>=1 && findingmax<(_parent.spaceapart)) {
			_parent.readoutmax_mc.readoutmax = day+" "+dayreadout;
			_parent.readoutmax_raw = dayreadout_raw;
			_parent.maxpos = this._x;
		}
	}
};
//
//if this bar is pressed, send to global function
this.onPress = function() {
	Barpressed(this._x, this.bar_mc._width, dayreadout_raw, day+" "+dayreadout, number);
};
this.onRollOver = function() {
	attachVisitorDisplayWidget(this._x, this.bar_mc._height, number, day, dayreadout);
	//_parent.whatday = convertMonth(dayreadout_raw.slice(4, 6), dayreadout_raw.slice(6, 8));
};
this.onRollOut = function() {
	//yep, you guessed it....detaches the bubble
	detachVisitorDisplayWidget();
	//_parent.whatday_txt._alpha = 0;
};