bar.colorTo("0x"+box_color, 0);
outline_mc.colorTo("0x"+box_color, 0);

bar.onEnterFrame = function () {
	// pre-load the interface
	if (percent != "100") {
		totalbites = _root.getBytesTotal();
		loadedbites = _root.getBytesLoaded();
		percent = (loadedbites/totalbites)*100;
		percent_read = Math.round(percent)+"%";
		percent_readxml = Math.round(percentxml)+"%";
		readout = (Math.round(loadedbites/1000))+"KB / "+(Math.round(totalbites/1000))+"KB";
		bar._width = percent;
		loading_data = "loading interface..."+readout;
	} else if (percent == "100" && my_xml.completed == "yes") {
		//gotoAndStop("interface");
		set_view_selector(howmany_days);
		delete bar;
	}
};
