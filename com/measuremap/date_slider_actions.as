/*
*Attached to the MC instance called '_root.slider_mc' on frame labled 'interface'
*
*DESCRIPTION
*	The function called setdottedlinesAndDays(); is the big one. It draws everything start there
*   Some MovieClip names (full path names)
		-_root.slider_mc: location of this .as file and is where everything else lives
		-_root.slider_mc.day_mc: is the bar that is duplicated (becomes day_mc+i...so day_mc22
		-_root.slider_mc.box_mc: is the line that stretches to follow the sliders
		-_root.slider_mc.sliderone_mc: left slider
		-_root.slider_mc.slidertwo_mc: left slider
		-_root.slider_mc.visitorvalue_txt: is the litte widget that comes up when you hover over a bar (there are some MCs in there too)
		-_root.slider_mc.line_mc: are the line of the graph

*/
// get the width of the line in order to set the limits of the slider handles
get_Handle_limits = function (what_handle) {
	var what_handle = what_handle;
	if (what_handle == "right") {
		return line_mc._x+line_mc._width-10;
	} else if (what_handle == "left") {
		return line_mc._x;
	} else {
		return "please tell me what handle you need, left or right";
	}
};
//set view status of date readouts
setviewStatus = "yes";
//set color of line (box_mc)
box_mc.colorTo("0x"+_parent.box_color, 0);
arrow_mc.colorTo("0x"+_parent.box_color, 0);
line_mc.bottom_line_mc.colorTo("0x"+_parent.line_color, 0);
//function that converts date formate (20050909) to words
_global.convertMonth = function(monthvalue, dayvalue) {
	if (monthvalue == 01) {
		var month = "Jan.";
	} else if (monthvalue == "02") {
		var month = "Feb.";
	} else if (monthvalue == "03") {
		var month = "March";
	} else if (monthvalue == "04") {
		var month = "April";
	} else if (monthvalue == "05") {
		var month = "May";
	} else if (monthvalue == "06") {
		var month = "June";
	} else if (monthvalue == "07") {
		var month = "July";
	} else if (monthvalue == "08") {
		var month = "Aug.";
	} else if (monthvalue == "09") {
		var month = "Sept.";
	} else if (monthvalue == "10") {
		var month = "Oct.";
	} else if (monthvalue == "11") {
		var month = "Nov.";
	} else if (monthvalue == "12") {
		var month = "Dec.";
	}
	day = dayvalue;
	// now let's return the sucker
	return month+" "+day;
};
//this.onEnterFrame = function() {
resize_display_boxes = function () {
	// set some positions and format for the date range readout things
	readoutmin_mc.readoutmin_txt.autoSize = "right";
	readoutmin_mc.left_mc._width = readoutmin_mc.readoutmin_txt._width-15;
	readoutmax_mc.readoutmax_txt.autoSize = "left";
	readoutmax_mc.right_mc._width = readoutmax_mc.readoutmax_txt._width-17;
	// set the box position and width to the slider handles
	box_mc._x = sliderone_mc._x+(sliderone_mc._width/2);
	box_mc._width = (slidertwo_mc._x)-(sliderone_mc._x);
};
setInterval(resize_display_boxes, 1);
//
set_viewStatus = function () {
	// determine whether the date range readout should be visible or not
	if (setviewStatus == "yes") {
		sliderone_mc._alpha = 100;
		slidertwo_mc._alpha = 100;
		if (readoutmin_mc.readoutmin == readoutmax_mc.readoutmax) {
			// in other words, if one day is selected pop up the middle date range readout
			readoutmiddle_mc._alpha = 100;
			readoutmax_mc._alpha = 0;
			readoutmin_mc._alpha = 0;
		} else {
			// else turn it off
			readoutmiddle_mc._alpha = 0;
			readoutmin_mc._alpha = 100;
			readoutmax_mc._alpha = 100;
		}
	}
	if (readoutmin_mc.readoutmin == readoutmax_mc.readoutmax) {
		readoutmiddle_mc._x = (sliderone_mc._x)-readoutmiddle_mc.readoutmiddle_txt._width+(readoutmiddle_mc.readoutmiddle_txt._width/2)+sliderone_mc._width+((slidertwo_mc._x-sliderone_mc._x)/2)-4;
		readoutmiddle_mc.readoutmiddle_txt.text = readoutmin_mc.readoutmin_txt.text;
	} else {
		readoutmin_mc._x = sliderone_mc._x;
		readoutmax_mc._x = slidertwo_mc._x;
	}
};
setInterval(set_viewStatus, 100);
move_date_view_indicator = function (howmany) {
	if (howmany == 30 || howmany == 60 || howmany == 120) {
		this.controller_mc.date_indicator_mc._alpha = 100;
		if (howmany == 30) {
			this.controller_mc.onemonth.gotoAndStop(2);
			this.controller_mc.date_indicator_mc.slideTo(this.controller_mc.onemonth._x, this.controller_mc.date_indicator_mc._y, .7, "easeOutExpo");
		} else {
			this.controller_mc.onemonth.gotoAndStop(1);
		}
		if (howmany == 60) {
			this.controller_mc.twomonth.gotoAndStop(2);
			this.controller_mc.date_indicator_mc.slideTo(this.controller_mc.twomonth._x, this.controller_mc.date_indicator_mc._y, .7, "easeOutExpo");
		} else {
			this.controller_mc.twomonth.gotoAndStop(1);
		}
		if (howmany == 120) {
			this.controller_mc.fourmonth.gotoAndStop(2);
			this.controller_mc.date_indicator_mc.slideTo(this.controller_mc.fourmonth._x, this.controller_mc.date_indicator_mc._y, .7, "easeOutExpo");
		} else {
			this.controller_mc.fourmonth.gotoAndStop(1);
		}
	} else {
		this.controller_mc.date_indicator_mc._alpha = 25;
	}
};
//this function creates the units and draws the dotted lines, so let's first get the date from the XML...
setdottedlinesAndDays = function (howmany) {
	// put the highest value in boxes
	if (_parent.highest_value != undefined && _parent.highest_value>=10) {
		// if values are less than 10 do this
		lenghtofnumber = _parent.highest_value.length-2;
		calculatenumber = 1;
		for (i=0; i<lenghtofnumber; i++) {
			this.calculatenumber += String(0);
		}
		if (calculatenumber == 1) {
			calculatenumber = 10;
		}
		highestvalue_rough = _parent.highest_value/Number(calculatenumber);
		highestvalue = Math.round(highestvalue_rough)*Number(calculatenumber);
		middlevalue = highestvalue/2;
	} else {
		// otherwise just do this
		highestvalue = _parent.highest_value;
		middlevalue = "";
	}
	// remove bars on view change
	for (i=howmanyhold; i>0; i--) {
		removeMovieClip("day_mc"+i);
		// if (howmany != 30) {
		// removeMovieClip("dotted_mc"+i);
		// }
	}
	// 
	// 
	// spaceapart accounts for the adjustment of the bars so the
	// sliders can fit on the left and the right. The 25 is to adjust all the days left some to allowo the right slider
	// to fit. I adjust the spacing on the left when I place the _x of the bars.
	// 
	thespace = line_mc._width-(sliderone_mc._width*2);
	spaceapart2 = (thespace)/howmany;
	// 
	// the following adjusts the right most position of the last bar.
	// 
	if (howmany == "30") {
		rightbuffer = 2;
		spaceapart = ((thespace-rightbuffer)/howmany);
	} else if (howmany == "60") {
		rightbuffer = 5;
		spaceapart = ((thespace-rightbuffer)/howmany);
	} else if (howmany == "120") {
		rightbuffer = 5;
		spaceapart = ((thespace-rightbuffer)/howmany);
	}
	howmanyhold = howmany;
	// since I'm loading in all the values (all 120 days) I need to only grab the nodes for the specific range
	howmany_adjusted = _parent.howmany_days-howmany;
	// get the earilest date which is the first value in the adjusted date
	earliest_date_raw = _parent.my_xml.firstChild.childNodes[0].childNodes[howmany_adjusted].attributes.date;
	// send it to a function to convert it to read like "June 05"
	earliest_date = convertMonth(earliest_date_raw.slice(4, 6), earliest_date_raw.slice(6, 8));
	// grab the highest value that was calculated when the XML was parsed
	if (_parent.highest_value == 0) {
		ratio = 50;
	} else {
		ratio = _parent.highest_value/50;
	}
	ia = 0;
	gotmin = "no";
	gotmax = "no";
	for (b=howmany_adjusted; b<120; b++) {
		// now let's draw the lines and stuff...weeee
		ia++;
		i = ia-1;
		// duplicate the bar
		duplicateMovieClip("day_mc", "day_mc"+i, i);
		// set the width
		this["day_mc"+i]._x = sliderone_mc._width+4+(line_mc._x+((spaceapart)*i));
		// grab the xpos of the bar
		xposofbar = sliderone_mc._width+spaceapart+(line_mc._x+((spaceapart)*i));
		// grab the visitor count
		visitor_count = _parent.my_xml.firstChild.childNodes[0].childNodes[b].firstChild.nodeValue;
		// if the above count is zero move it up a bit so people can see an indication of the day
		if (visitor_count != 0) {
			buffer = 6;
		} else {
			buffer = 1;
		}
		// this["day_mc"+i].bar_mc._height = (visitor_count/ratio)+Number(buffer);
		if (visitor_count>0) {
			buffer = 6;
			// set the height of the bar
			this["day_mc"+i].bar_mc._height = (visitor_count/ratio)+Number(buffer);
		} else if (visitor_count == 0) {
			buffer = 1;
			this["day_mc"+i].bar_mc._height = (visitor_count/ratio)+Number(buffer);
		} else {
			this["day_mc"+i].bar_mc._height = 0;
		}
		// silo_mc is the invisible hot spot so people can rollover the area to get the value
		this["day_mc"+i].silo_mc._height = 50;
		// then set number to the count
		this["day_mc"+i].number = visitor_count;
		// set dayreadout_raw to the raw date string
		this["day_mc"+i].dayreadout_raw = String(_parent.my_xml.firstChild.childNodes[0].childNodes[b].attributes.date);
		dayreadout_raw = _parent.my_xml.firstChild.childNodes[0].childNodes[b].attributes.date;
		// make some adjustments to the bar and silo depending on the range
		if (howmany == 120) {
			// this["day_mc"+i].bar_mc.gotoAndStop(2);
			this["day_mc"+i].bar_mc._width = 1;
			// gotoAndStop(2);
			this["day_mc"+i].silo_mc._visible = false;
		} else {
			barwidth_2 = Math.round(spaceapart/1.3);
			this["day_mc"+i].bar_mc._width = Math.round(spaceapart/1.3);
			this["day_mc"+i].silo_mc._visible = true;
			this["day_mc"+i].silo_mc._alpha = 0;
			this["day_mc"+i].silo_mc._width = Math.round(spaceapart/1.3);
		}
		// 
		// exampled date string 20050601T18:58:44-20050601T18:58:44
		// this is the loop that evaluates the date for each new bar and checks if it's equal to the given date range
		if (_parent.date_range.length<18) {
			// in other words, the date range is a single day
			if (_parent.date_range.slice(0, 8) == dayreadout_raw.slice(0, 8)) {
				// true when one day is selected
				// got the min value
				gotmin = "yes";
				// if (howmany == 120) {
				// set the position of the left slider to the day selected
				sliderone_mc._x = this["day_mc"+i]._x-sliderone_mc._width;
				// }
			}
			if (_parent.date_range.slice(0, 8) == dayreadout_raw.slice(0, 8)) {
				// same as above
				gotmax = "yes";
				if (howmany == 120) {
					slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-3;
				} else {
					slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-4;
				}
			}
		}
		if (_parent.date_range.slice(0, 8) == dayreadout_raw.slice(0, 8)) {
			gotmin = "yes";
			sliderone_mc._x = this["day_mc"+i]._x-sliderone_mc._width;
		} else if (_parent.date_range.slice(18, 26) == dayreadout_raw.slice(0, 8)) {
			// in othe words, multiple dates are selected
			gotmax = "yes";
			trace("This is the max range, and this is the x position "+xposofbar);
			if (howmany == 120) {
				slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-3;
			} else {
				slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-4;
			}
		}
		// this checks if only one day is selected
		if (_parent.date_range.slice(0, 8) == dayreadout_raw.slice(0, 8) && _parent.date_range.slice(18, 26) == dayreadout_raw.slice(0, 8)) {
			sliderone_mc._x = this["day_mc"+i]._x-sliderone_mc._width;
			if (howmany == 120) {
				slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-3;
			} else if (howmany == 14) {
				trace("14 YO");
				slidertwo_mc._x = this["day_mc"+i]._x+(spaceapart-14);
			} else if (howmany == 7) {
				trace("14 YO");
				slidertwo_mc._x = this["day_mc"+i]._x+(spaceapart-21);
			} else {
				slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-4;
			}
			gotmax = "yes";
			gotmin = "yes";
		}
		if (_parent.date_range == "today") {
			sliderone_mc._x = this["day_mc"+i]._x-sliderone_mc._width;
			if (howmany == 120) {
				slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-3;
			} else if (howmany == 14) {
				trace("14 YO");
				slidertwo_mc._x = this["day_mc"+i]._x+(spaceapart-14);
			} else if (howmany == 7) {
				trace("14 YO");
				slidertwo_mc._x = this["day_mc"+i]._x+(spaceapart-21);
			} else {
				slidertwo_mc._x = this["day_mc"+i]._x+spaceapart-4;
			}
			gotmax = "yes";
			gotmin = "yes";
		}
	}
	// position the red bar in the case that someone selects a range outside the viewable range
	checkforuserdefinedrange(gotmin, gotmax);
	// move the little box around the right date view
	move_date_view_indicator(howmany);
	// turn off the first day_mc
	day_mc._visible = false;
	// line_mc.swapDepths(1);
	// set some depths of the objects
	box_mc.swapDepths(160);
	sliderone_mc.swapDepths(this.getNextHighestDepth());
	slidertwo_mc.swapDepths(this.getNextHighestDepth());
	arrow_mc.swapDepths(this.getNextHighestDepth());
	// snapHandles();
};
//this function checks to see if the selected date range is outside the viewable area
checkforuserdefinedrange = function (gotmin, gotmax) {
	if (gotmin == "no" && gotmax != "no") {
		box_mc._x = line_mc._x;
		sliderone_mc._x = line_mc._x+4;
		arrow_mc._alpha = 100;
		sliderone_mc._visible = false;
		slidertwo_mc._visible = true;
		readoutmin_mc._visible = false;
		box_mc._alpha = 100;
		alloutofrange_txt = "";
	} else if (gotmin == "no" && gotmax == "no") {
		box_mc._alpha = 0;
		arrow_mc._alpha = 0;
		slidertwo_mc._x = line_mc._x+4;
		sliderone_mc._visible = false;
		slidertwo_mc._visible = false;
		readoutmin_mc._visible = false;
		readoutmax_mc._visible = false;
		alloutofrange_txt._visible = true;
		if (readoutmin != readoutmax) {
			alloutofrange_txt = "<p align='center'>The range you have selected, "+"<b>"+readoutmin+"</b>"+" - "+"<b>"+readoutmax+"</b>"+", is not visible in this view.<br> Click a date or select a larger view to see your range.</p>";
		} else {
			alloutofrange_txt = "<p align='center'>The date you have selected, "+"<b>"+readoutmin+"</b>"+", is not visible in this view.<br> Click a date or select a larger view to see your date.</p>";
		}
	} else {
		alloutofrange_txt = "";
		box_mc._alpha = 100;
		sliderone_mc._visible = true;
		arrow_mc._alpha = 0;
		slidertwo_mc._visible = true;
		readoutmin_mc._visible = true;
		readoutmax_mc._visible = true;
		alloutofrange_txt._visible = false;
	}
};
//set the initial view...which is month view or 30
howmany_setting = 30;
setdottedlinesAndDays(30);
//this function executes when a bar is pressed. It moves the handles into position and sends the date range to the javascript function
_global.Barpressed = function(barpos, barwidth, date, clean_date, number) {
	sliderone_mc_pos = barpos-sliderone_mc._width;
	slidertwo_mc_pos = barpos+barwidth;
	sliderone_mc.slideTo(sliderone_mc_pos, 97, .5, "easeOutExpo");
	slidertwo_mc.slideTo(slidertwo_mc_pos, 97, .5, "easeOutExpo");
	getminandmax();
	checkDateReadout();
	// readjust the line
	gotmin = "yes";
	checkforuserdefinedrange(gotmin);
	datetogether = date;
	_parent.date_range = date+"-"+date;
	trace(_parent.date_range);
	sendtoJavaScript(datetogether, clean_date, number);
	checkDateReadout();
	// get total count in range
	trace("THis is the total "+number+" howmanyu "+howmany_adjusted);
};
//snap handles after a onRelease except if view is set at 120
_global.snapHandles = function() {
	// spaceapart
	if (howmany_setting == "30" || howmany_setting == "60") {
		sliderone_mc_pos = minpos-(sliderone_mc._width);
		sliderone_mc.slideTo(sliderone_mc_pos, 97, .5, "easeOutExpo");
		// slidertwo_mc._x = maxpos+(spaceapart2/1.5);
		slidertwo_mc_pos = maxpos+barwidth_2;
		// maxpos+(spaceapart/1.5);
		slidertwo_mc.slideTo(slidertwo_mc_pos, 97, .5, "easeOutExpo");
	} else {
	}
	checkDateReadout();
	// total_count = Number(0);
	getTotalCount();
};
getTotalCount = function () {
	count_these = 120-howmany_adjusted;
	var total_count:Number = 0;
	for (d=count_these; d>0; d--) {
		if (this["day_mc"+d].in_range == "yes") {
			var total_count:Number = Number(total_count)+Number(this["day_mc"+d].number);
			total_count_display = Number(total_count)+Number(this["day_mc"+d].number);
		}
	}
	trace("THis is the total "+total_count+" howmanyu "+howmany_adjusted);
	sendtoJavaScript(get_Raw_date(), get_Clean_date(), total_count_display);
	// sendtoJavaScript();
};
get_Raw_date = function () {
	if (readoutmin_raw == readoutmax_raw) {
		return readoutmin_raw;
	} else {
		return readoutmin_raw+"-"+readoutmax_raw;
	}
};
get_Clean_date = function () {
	if (readoutmin_mc.readoutmin == readoutmax_mc.readoutmax) {
		return readoutmin_mc.readoutmin;
	} else {
		return readoutmin_mc.readoutmin+"-"+readoutmax_mc.readoutmax;
	}
};
//function that sends date range to javascript
sendtoJavaScript = function (raw_date, clean_date, total_count) {
	if (_parent.javascript == "yes") {
		_parent.proxy.call("updatePage", raw_date, clean_date, total_count);
	}
	_parent.date_range = readoutmin_raw+"-"+readoutmax_raw;
};
//controller actions
//one month
controller_mc.onemonth.onRelease = function() {
	setdottedlinesAndDays(30);
};
//two month
controller_mc.twomonth.onRelease = function() {
	setdottedlinesAndDays(60);
	//dayreadout_raw = "";
};
//four month
controller_mc.fourmonth.onRelease = function() {
	setdottedlinesAndDays(120);
};
nav_bmc.onRollOver = moveMeRight;
//today button
today_btn.onRollOver = function() {
	today_btn.gotoAndStop(2);
};
today_btn.onRollOut = function() {
	today_btn.gotoAndStop(1);
};
//when today is clicked
today_btn.onRelease = function() {
	//day_mc120.
	if (howmanyhold == 7) {
		Barpressed(day_mc6._x, day_mc6.bar_mc._width, day_mc6.dayreadout_raw);
	} else if (howmanyhold == 14) {
		Barpressed(day_mc13._x, day_mc13.bar_mc._width, day_mc13.dayreadout_raw);
	} else if (howmanyhold == 30) {
		Barpressed(day_mc29._x, day_mc29.bar_mc._width, day_mc29.dayreadout_raw);
	} else if (howmanyhold == 60) {
		Barpressed(day_mc59._x, day_mc59.bar_mc._width, day_mc59.dayreadout_raw);
	} else if (howmanyhold == 120) {
		Barpressed(day_mc119._x, day_mc119.bar_mc._width, day_mc119.dayreadout_raw);
	}
	trace(howmanyhold);
};
////
///
//
//handle Actions
//
///
////
sliderone_mc.onPress = function() {
	rightlimit = slidertwo_mc._x-slidertwo_mc._width;
	//sliderone_mc.startDrag(false, leftlimit_handles, 97, rightlimit, 97);
	sliderone_mc.startDrag(false, get_Handle_limits("left"), 97, rightlimit, 97);
	setviewStatus = "yes";
};
sliderone_mc.onRelease = function() {
	stopDrag();
	snapHandles();
	getminandmax();
};
sliderone_mc.onReleaseOutside = function() {
	stopDrag();
	snapHandles();
};
sliderone_mc.onRollOut = function() {
	setviewStatus = "no";
};
sliderone_mc.onRollOver = function() {
	setviewStatus = "yes";
};
slidertwo_mc.onPress = function() {
	leftlimit = sliderone_mc._x+sliderone_mc._width;
	slidertwo_mc.startDrag(false, leftlimit, 97, get_Handle_limits("right"), 97);
	setviewStatus = "yes";
};
slidertwo_mc.onRollOut = function() {
	setviewStatus = "no";
};
slidertwo_mc.onRelease = function() {
	stopDrag();
	snapHandles();
	getminandmax();
};
slidertwo_mc.onRollOver = function() {
	setviewStatus = "yes";
};
slidertwo_mc.onReleaseOutside = function() {
	stopDrag();
	snapHandles();
};
//attach dispaly widget when bar is clicked
_global.attachVisitorDisplayWidget = function(xpos, height, number, day, dayreadout) {
	// format readout
	visitorvalue_txt.visitorvalue = number*1+" "+_parent.slider_variable;
	visitorvalue_txt.datedisplay = "on "+dayreadout;
	visitorvalue_txt.visitorvalue_txt.autoSize = true;
	visitorvalue_txt.datedisplay_txt.autoSize = true;
	visitorvalue_txt.datedisplay = "on "+day+" "+dayreadout;
	if (height<5) {
		visitorvalue_txt._y = (_parent.line_mc._y)-height-10;
	} else {
		visitorvalue_txt._y = (line_mc._y)-height-6;
	}
	visitorvalue_txt.alphaTo(100, .5, "easeOutExpo");
	if (visitorvalue_txt.datedisplay_txt._width>visitorvalue_txt.visitorvalue_txt._width) {
		visitorvalue_txt.middle_mc._width = (visitorvalue_txt.datedisplay_txt._width)+3;
	} else if (visitorvalue_txt.datedisplay_txt._width<visitorvalue_txt.visitorvalue_txt._width) {
		visitorvalue_txt.middle_mc._width = (visitorvalue_txt.visitorvalue_txt._width)+3;
	}
	visitorvalue_txt.left_mc._x = visitorvalue_txt.middle_mc._x;
	visitorvalue_txt.right_mc._x = visitorvalue_txt.middle_mc._x+visitorvalue_txt.middle_mc._width;
	visitorvalue_txt.datedisplay_txt._x = visitorvalue_txt.middle_mc._x+(visitorvalue_txt.middle_mc._width/2)-(visitorvalue_txt.datedisplay_txt._width/2);
	visitorvalue_txt.visitorvalue_txt._x = visitorvalue_txt.middle_mc._x+(visitorvalue_txt.middle_mc._width/2)-(visitorvalue_txt.visitorvalue_txt._width/2);
	visitorvalue_txt.arrow_mc._x = visitorvalue_txt.middle_mc._x+(visitorvalue_txt.middle_mc._width/2);
	visitorvalue_txt.swapDepths(10000);
	whatday_txt._x = Number(xpos)+1;
	visitorvalue_txt._x = Number(xpos)-(visitorvalue_txt.middle_mc._width/2);
};
_global.detachVisitorDisplayWidget = function() {
	visitorvalue_txt.alphaTo(0, .5, "easeOutExpo");
};
//checks to see if user mouse is still on canvas if not fade things out
var mouseListener:Object = new Object();
mouseListener.onMouseMove = function() {
	if (_root._ymouse>80 && _root._ymouse<100 && _root._xmouse>5 && _root._xmouse<550) {
		setviewStatus = "yes";
	} else {
		setviewStatus = "no";
		readoutmin_mc.alphaTo(0, .5, "linear");
		readoutmiddle_mc.alphaTo(0, .5, "linear");
		readoutmax_mc.alphaTo(0, .5, "linear");
	}
	updateAfterEvent();
};
Mouse.addListener(mouseListener);
measuremap_mc.onRelease = function() {
	getURL("http://www.measuremap.com/developer/slider", "_blank");
};
measuremap_mc.onRollOver = function() {
	this._alpha = 50;
};
measuremap_mc.onRollOut = function() {
	this._alpha = 100;
};
